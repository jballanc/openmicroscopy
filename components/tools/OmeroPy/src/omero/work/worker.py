#!/usr/bin/env python
# -*- coding: utf-8 -*-
"""

:author: Joshua Ballanco <jballanc@glencoesoftware.com>

Work processing worker

Copyright (C) 2013 Glencoe Software, Inc.
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:

1. Redistributions of source code must retain the above copyright notice, this
   list of conditions and the following disclaimer.
2. Redistributions in binary form must reproduce the above copyright notice,
   this list of conditions and the following disclaimer in the documentation
   and/or other materials provided with the distribution.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS 'AS IS' AND
ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR
ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
(INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

"""

import os
import sys
import logging
import pickle
import importlib

from subprocess import Popen, PIPE, STDOUT
from multiprocessing import Process, Pipe

import zmq
from zmq.eventloop.ioloop import ZMQIOLoop
from zmq.eventloop.zmqstream import ZMQStream

log = logging.getLogger("work.worker")
if os.getenv("DEBUG"):
    logging.basicConfig(level=logging.DEBUG)
else:
    logging.basicConfig(level=logging.INFO)


def hosted_func(func_spec, pythonpath):
    """
    Simple function wrapper for running a function in a subprocess and
    communicating the output back to the parent process via pipe.
    """
    def __target_func(pipe, *args, **kwargs):
        log.debug("Running function: %s" % func_spec)
        module_name, func_name = func_spec.rsplit(".", 1)
        sys.path = pythonpath
        try:
            module = importlib.import_module(module_name)
            func = getattr(module, func_name)

            rv = func(*args, **kwargs)
            success = True

        except:
            err_type, msg, _ = sys.exc_info()
            success = False
            if err_type == ImportError:
                msg = """
                      ERROR: Could not import function -- %s

                      %s
                      """ % (func_spec, msg)
        finally:
            pipe.send([success, rv])
            pipe.close()

    return __target_func


def exec_cmd(cmd, path="", args=()):
    cmd = [cmd]+args
    env = os.environ
    env["PATH"] = path
    log.debug("Executing command: %s" % cmd)

    child = Popen(cmd, stdout=PIPE, stderr=STDOUT, env=env)
    child_out = ""

    # TODO: Polling kinda sucks...`select` would be better
    while child.poll() is None:
        out, _ = child.communicate()
        child_out += out

    if child.returncode == 0:
        return child_out
    else:
        return "Problem executing command: %s" % child_out


def exec_func(func_spec, path=":".join(sys.path), args=(), kwargs={}):
    parent, child = Pipe()
    pythonpath = path.split(":")
    target = hosted_func(func_spec, pythonpath)
    p = Process(target=target, args=[child]+args, kwargs=kwargs)
    p.start()
    p.join()
    succ, out = parent.recv()
    if succ:
        return out
    else:
        return "Problem calling function: %s" % out


class Worker(object):
    """
    The Worker class encapsulates a worker process that waits on a socket for
    incoming work requests. Work requests are received on a ZeroMQ "PULL"
    socket as a multipart message. The message consists of a tuple of work ID,
    work type (command-line or function), the filesystem path for a command or
    full module import path for a function, and a list of arguments. Once the
    work is completed, the output of the command or return value from the
    function is communicated back to the server via a ZeroMQ "PUB" socket.

    Note: The first argument must be the full PATH or PYTHON_PATH from the
    client machine for the command or function to call.
    """
    def __init__(self, server_addr,
                 protocol="tcp",
                 work_port=5557,
                 comm_port=5558):
        self.work_addr = "%s://%s:%s" % (protocol, server_addr, work_port)
        self.comm_addr = "%s://%s:%s" % (protocol, server_addr, comm_port)

        self.ctx = zmq.Context()
        self.work_sock = self.ctx.socket(zmq.PULL)
        self.work_sock.connect(self.work_addr)

    def do_work(self, msg):
        log.info("Received work request: %s" % str(msg[:3]))
        work_id, work_type, cmd_or_func, path = msg[:4]
        args = msg[4:]
        log.debug("Work path: %s" % path)
        log.debug("Arguments: %s" % str(args))

        out_sock = self.ctx.socket(zmq.PUB)
        out_sock.connect(self.comm_addr)

        # The server must open it's corresponding "SUB" socket before
        # distributing work. This initial response on the worker's "PUB" socket
        # is intended to overcome the ZeroMQ limitation that the first message
        # on a PUB/SUB pair is always missed by the subscriber.
        out_sock.send_multipart([work_id, "ACK"])

        try:
            if work_type == "func":
                out = exec_func(cmd_or_func, path=path, args=args)
            elif work_type == "cmd":
                out = exec_cmd(cmd_or_func, path=path, args=args)
            else:
                log.debug("Unrecognized work type: %s", work_type)
                raise ValueError()
            log.debug("Work finished: %s" % out)
            out_sock.send_multipart([work_id, "DONE", pickle.dumps(out)])
            log.debug("Sent results for work ID: %s" % work_id)
        except:
            _, msg, _ = sys.exc_info()
            log.debug("Problem performing work: %s" % msg)
            out_sock.send_multipart([work_id, "FAIL", msg])
        finally:
            out_sock.close()

    def wait_for_work(self):
        self.work_stream = ZMQStream(self.work_sock)
        self.work_stream.on_recv(self.do_work)

        log.info("Listening for work at %s", self.work_addr)

        ZMQIOLoop.instance().start()

if __name__ == "__main__":
    worker = Worker("localhost")
    worker.wait_for_work()
