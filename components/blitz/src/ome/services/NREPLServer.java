package ome.services;

import java.io.StringReader;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationContextAware;

import clojure.lang.Compiler;
import clojure.lang.RT;

import ome.system.OmeroContext;

class NREPLServer implements ApplicationContextAware {
    private final static Logger log = LoggerFactory.getLogger(NREPLServer.class);

    private OmeroContext context;

    private static final String INIT = "(require 'clojure.tools.nrepl.server) "
       + "(clojure.tools.nrepl.server/start-server :port 9000)";

    public void setApplicationContext(ApplicationContext applicationContext) {
        this.context = (OmeroContext) applicationContext;
    }

    public void startREPL() {
        try {
            // Load the Clojure Runtime class
            Class.forName("clojure.lang.RT");

            Compiler.load(new StringReader(INIT));

            RT.var("omero", "*context*", this.context);
        } catch (ClassNotFoundException e) {
            log.debug("Problem starting nREPL: " + e);
        }
    }
}
