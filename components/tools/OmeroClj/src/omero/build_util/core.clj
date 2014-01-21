(ns omero.build-util.core
  (:require [omero.build-util.package :as pkg])
  (:gen-class))

(defn- main [path]
  (pkg/resolve-pkg-graph path))

(defn -main [& args]
  (if (> (count args) 1)
    (println "Error: only one argument allowed currently...")
    (main (first args))))
