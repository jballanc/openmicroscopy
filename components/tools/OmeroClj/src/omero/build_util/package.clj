(ns omero.build-util.package
  (:require [clojure.java.io :as io]
            [clojure.string :as s]
            [omero.build-util.resolver :refer [generate-build-order]])
  (:import (java.io BufferedReader FileReader)))


(def package-pattern #"^\s*package\s*([\w\.\*]*)")
(def import-pattern #"^\s*import\s*([\w\.]*)")
(def import-trim-pattern #"\.(\w*|\*)$")

(defn assoc-pkg-imports [package-map lines]
  (let [package-name-fn (comp second (partial re-find package-pattern))
        import-name-fn (comp second (partial re-find import-pattern))
        [package-name] (filter identity (map package-name-fn lines))
        imports (filter identity (map import-name-fn lines))
        import-packages (map #(s/replace % import-trim-pattern "") imports)
        prev-import-packages (get package-map package-name #{})
        all-import-packages (into prev-import-packages import-packages)]
    (assoc package-map package-name all-import-packages)))

(defn map-imports [fs]
  (->> (filter (complement #(.isDirectory %)) fs)
       (filter #(re-find #"\.java$" (.getName %)))
       (map #(line-seq (BufferedReader. (FileReader. %))))
       (reduce assoc-pkg-imports {})))

(defn print-build-order [parent-dir]
  (let [deps-map (map-imports (file-seq (io/file parent-dir)))
        build-order (generate-build-order deps-map)]
    (println build-order)
    #_(doseq [pkgs build-order]
      (println "<myjavac>")
      (println "\t<src path=\"$ {src.dir}\"/>")
      (println "\t<src path=\"$ {src.dest}\"/>")
      (println "\t<src path=\"$ {basedir}/generated\"/>")
      (doseq [pkg pkgs]
        (println "\t<include name=\"" (s/replace pkg "." "/") "\"/>"))
      (println "</myjavac>"))))

(comment

  (print-build-order "/Users/jballanc/Source/openmicroscopy/components/blitz")

  (clojure.pprint/pprint (map-imports ((io/file "/Users/jballanc/Source/openmicroscopy/components/blitz"))))

  (map-imports files)

  (def files (file-seq
      (io/file "/Users/jballanc/Source/openmicroscopy/components/server/src/ome/services")))

  (def only-files (filter (complement #(.isDirectory %)) files))

  (def first-lines (line-seq (BufferedReader. (FileReader. (first only-files)))))
  (def second-lines (line-seq (BufferedReader. (FileReader. (second only-files)))))

  (assoc-pkg-imports (assoc-pkg-imports {} first-lines) second-lines)


  )

