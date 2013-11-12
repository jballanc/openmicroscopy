#!/usr/bin/env python
# -*- coding: utf-8 -*-
"""

:author: Joshua Ballanco <jballanc@glencoesoftware.com>

Work processing server

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
import random
import string
import logging
import pickle

import zmq
from zmq.eventloop.ioloop import ZMQIOLoop
from zmq.eventloop.zmqstream import ZMQStream

log = logging.getLogger("work.server")
if os.getenv("DEBUG"):
    logging.basicConfig(level=logging.DEBUG)
else:
    logging.basicConfig(level=logging.INFO)


class Batch(object):
    """
    The Batch class manages the arguments and return values for a batch of
    work. It is initialized with a job type and a list of arguments. Each
    subsequent call to work_items returns a tuple suitable for distribution to
    workers. Calls to put_result accept a tuple as returned by a worker and
    gathers the results in the results property.
    """
    def __init__(self, work_type, cmd_or_func, path="", args_list=[]):
        self.id = "".join(random.choice(string.hexdigits) for i in range(6))
        self.work_type = work_type
        self.cmd_or_func = cmd_or_func
        self.path = path
        self.batch_list = [{"args": args, "out": None} for args in args_list]

        # For use when the batch is finished processing:
        self.finished = False
        self.results = []

    def work_items(self):
        for idx, batch_item in enumerate(self.batch_list):
            work_item = [self.id+"-"+str(idx),
                         self.work_type,
                         self.cmd_or_func,
                         self.path]
            work_item += batch_item["args"]
            yield work_item

    def put_result(self, msg):
        log.debug("Batch results recieved: %s" % str(msg))
        work_id, state = msg[:2]
        batch_id, idx = work_id.split("-")
        idx = int(idx)
        if batch_id != self.id:
            log.debug("Received results for batch id: %s, expected id: %s" %
                      batch_id, self.id)
            raise ValueError()

        if state == "DONE":
            out = pickle.loads(msg[2])
            self.batch_list[idx]["out"] = out

            # Check to see if any batch items are missing output, while
            # gathering output that has already been collected
            finished = True
            for idx, batch_item in enumerate(self.batch_list):
                if batch_item["out"] is None:
                    finished = False
                    break
                elif len(self.results) <= idx:
                    self.results.append(batch_item["out"])
            self.finished = finished


class Server(object):
    """
    The Server class handles communication between clients requesting work to
    be done and the worker processes that will do the actual work. Incoming
    work requests consist of a tuple matching the tuple expected by workers,
    except with a client ID in place of the worker ID and with a list of
    argument lists in place of a single argument list.
    """
    def __init__(self, protocol="tcp",
                 work_port=5557,
                 comm_port=5558,
                 ctrl_port=5559,
                 resp_port=5560):
        self.work_addr = "%s://*:%s" % (protocol, work_port)
        self.comm_addr = "%s://*:%s" % (protocol, comm_port)
        self.ctrl_addr = "%s://*:%s" % (protocol, ctrl_port)
        self.resp_addr = "%s://*:%s" % (protocol, resp_port)

        self.ctx = zmq.Context()
        self.work_sock = self.ctx.socket(zmq.PUSH)
        self.work_sock.bind(self.work_addr)
        self.ctrl_sock = self.ctx.socket(zmq.PULL)
        self.ctrl_sock.bind(self.ctrl_addr)

    def send_job(self, msg):
        log.info("Received job request: %s" % str(msg[:3]))
        client_id, work_type, cmd_or_func, path = msg[:4]
        args_list = pickle.loads(msg[4])
        log.debug("Job path: %s" % path)
        log.debug("Arguments: %s" % str(args_list))

        # Prepare a socket to send the response to the client
        resp_sock = self.ctx.socket(zmq.PUB)
        resp_sock.bind(self.resp_addr)
        resp_sock.send_multipart([client_id, "ACK"])

        # Create the batch and prepare the communication socket to receive
        # responses from the workers
        batch = Batch(work_type, cmd_or_func, path=path, args_list=args_list)
        comm_sock = self.ctx.socket(zmq.SUB)
        comm_sock.subscribe = batch.id
        comm_sock.bind(self.comm_addr)

        # Set up the stream to receive results from the workers. Also attach
        # the batch and the response socket so we can record the worker
        # responses and send results to the client when the work is finished.
        stream = ZMQStream(comm_sock)
        stream.resp_sock = resp_sock
        stream.batch = batch
        stream.on_recv_stream(self.recv_results)

        # Finally, dispatch the work to be done
        for item in batch.work_items():
            log.debug("Sending item to worker: %s" % item)
            self.work_sock.send_multipart(item)

    def recv_results(self, stream, msg):
        log.debug("Received results from worker: %s" % str(msg))
        stream.batch.put_result(msg)
        if stream.batch.finished:
            log.info("Batch %s finished!" % stream.batch.id)
            resp = [stream.client_id,
                    "DONE",
                    pickle.dumps(stream.batch.results)]
            self.resp_sock.send_multipart(resp)
            log.debug("Sent response to client: %s" % resp)
            stream.stop_on_recv()
            stream.close()

    def wait_for_job(self):
        self.job_stream = ZMQStream(self.ctrl_sock)
        self.job_stream.on_recv(self.send_job)

        log.info("Listening for job requests at %s" % self.ctrl_addr)

        ZMQIOLoop.instance().start()

if __name__ == "__main__":
    server = Server()
    server.wait_for_job()
