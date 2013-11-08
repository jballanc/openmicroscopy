#!/usr/bin/env python
# -*- coding: utf-8 -*-
"""
   Work distribution worker process

   Copyright 2013 Glencoe Software, Inc. All rights reserved.
   Use is subject to license terms supplied in LICENSE.txt

"""

import os
import sys
import importlib

from subprocess import Popen, PIPE
from multiprocessing import Process, Pipe

import zmq
from zmq.eventloop.ioloop import ZMQIOLoop
from zmq.eventloop.zmqstream import ZMQStream


def debug_log(msg):
    if os.getenv("DEBUG"):
        print msg


def hosted_func(func_spec):
    module_name, func_name = func_spec.rsplit(".", 1)
    try:
        module = importlib.import_module(module_name)
        func = getattr(module, func_name)

        def __target_func(pipe, *args, **kwargs):
            rv = func(*args, **kwargs)
            pipe.send([True, rv])
            pipe.close()

    except:
        err_type, msg, _ = sys.exc_info()
        if err_type == ImportError:
            msg = """
                  ERROR: Could not import function -- %s

                  %s
                  """ % (func_spec, msg)

        def __target_func(pipe, *args, **kwargs):
            pipe.send([False, msg])
            pipe.close()

    return __target_func


def exec_cmd(cmd):
    child = Popen(cmd, stdout=PIPE, stderr=PIPE, shell=True)
    child_out = ""
    child_err = ""

    # TODO: Polling kinda sucks...`select` would be better
    while child.poll() is None:
        out, err = child.communicate()
        child_out += out
        child_err += err

    if child.returncode == 0:
        return child_out
    else:
        return "Problem executing command: %s" % child_err


def exec_func(func_spec, args=(), kwargs={}):
    parent, child = Pipe()
    target = hosted_func(func_spec)
    p = Process(target=target, args=[child]+args, kwargs=kwargs)
    p.start()
    p.join()
    succ, out = parent.recv()
    if succ:
        return out
    else:
        return "Problem calling function: %s" % out


class Worker(object):
    def __init__(self, server_addr,
                 protocol="tcp",
                 work_port=5557,
                 comm_port=5558):
        self.server_addr = server_addr
        self.protocol = protocol
        self.work_port = work_port
        self.comm_port = comm_port
        self.work_addr = "%s://%s:%s" % (protocol, server_addr, work_port)
        self.comm_addr = "%s://%s:%s" % (protocol, server_addr, comm_port)

        self.ctx = zmq.Context()
        self.work_sock = self.ctx.socket(zmq.PULL)
        self.work_sock.connect(self.work_addr)

    def do_work(self, msg):
        if os.getenv("DEBUG"):
            print "Received work: %s" % msg
        work_id, work_type, cmd_or_func = msg[:3]
        args = msg[3:]
        out_sock = self.ctx.socket(zmq.PUB)
        out_sock.connect(self.comm_addr)
        out_sock.send_multipart([work_id, "ACK"])

        try:
            if work_type == "func":
                out = exec_func(cmd_or_func, args=args)
            else:
                out = exec_cmd([cmd_or_func, args])
            debug_log("Work finished: %s" % out)
            out_sock.send_multipart([work_id, "DONE", str(out)])
        except:
            _, msg, _ = sys.exc_info()
            debug_log("Problem performing work: %s" % msg)
            out_sock.send_multipart([work_id, "FAIL", msg])
        finally:
            out_sock.close()

    def wait_for_work(self):
        self.work_stream = ZMQStream(self.work_sock)
        self.work_stream.on_recv(self.do_work)
        debug_log("Starting event loop...")
        ZMQIOLoop.instance().start()

if __name__ == "__main__":
    worker = Worker("localhost", work_port=5557, comm_port=5558)
    worker.wait_for_work()
