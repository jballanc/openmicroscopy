#!/usr/bin/env python
# -*- coding: utf-8 -*-
"""

:author: Joshua Ballanco <jballanc@glencoesoftware.com>

Client for the distributed work processor

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
import pickle
import random
import string

from multiprocessing import Process, Pipe

import zmq

import logging
log = logging.getLogger("work.client")
if os.getenv("DEBUG"):
    logging.basicConfig(level=logging.DEBUG)
else:
    logging.basicConfig(level=logging.INFO)


class Client(object):
    def __init__(self,
                 server="localhost",
                 protocol="tcp",
                 ctrl_port=5559,
                 resp_port=5560):
        self.id = "".join(random.choice(string.hexdigits) for i in range(6))
        self.ctrl_addr = "%s://%s:%s" % (protocol, server, ctrl_port)
        self.resp_addr = "%s://%s:%s" % (protocol, server, resp_port)

        self.ctx = zmq.Context()
        self.ctrl_sock = self.ctx.socket(zmq.PUSH)
        self.ctrl_sock.connect(self.ctrl_addr)

    def listen(self, write):
        resp_sock = zmq.Context().socket(zmq.SUB)
        resp_sock.subscribe = self.id
        resp_sock.connect(self.resp_addr)

        log.debug("Ready to listen for a response...")

        msg = resp_sock.recv_multipart()

        log.debug("Received results: %s" % str(msg))
        if msg[1] == "DONE":
            write.send(msg[2])
            write.close()
            resp_sock.close()

    def send_job(self, work_type, cmd_or_func, path, args_list):
        # Setup response channel first
        read, write = Pipe()
        p = Process(target=self.listen, args=[write])
        p.start()

        # Send job request
        log.info("Sending job: %s | %s" % (cmd_or_func, str(args_list)))
        args = pickle.dumps(args_list)
        self.ctrl_sock.send_multipart([self.id, work_type, cmd_or_func,
                                       path, args])

        # Wait for the results
        p.join()
        out = read.recv()
        log.debug("Result from listener: %s" % str(out))
        read.close()
        return pickle.loads(out)
