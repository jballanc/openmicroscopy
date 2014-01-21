(ns omero.build-util.resolver
  (:require [clojure.core.logic :as cl]
            (clojure.core.logic [pldb :as pl]
                                [fd :as fd])
            [clojure.set :as set]))

(cl/defna unwrapo
  "Unwrapps an arbitrarily deeply nested list"
  [l o]
  ([[e] o]
   (unwrapo e o))
  ([[f . r] o]
   (cl/conso f r o)))

(comment "Examples for how 'unwrapo' works:"

  (cl/run* [q] (unwrapo [1] q))

  (cl/run* [q] (unwrapo [[1]] q))

  (cl/run* [q] (unwrapo [[[1]]] q))

  (cl/run* [q] (unwrapo [[['([1])]]] q))

  (cl/run* [q] (unwrapo [[[1 2]]] q))

  (cl/run* [q] (cl/== q [[[1 2]]]) (unwrapo q [1 2]))

  )

(cl/defna flatteno
  "Flattens a list of lists 'l' into 'o'"
  [l o]
  ([[f . r] o]
   (cl/fresh [uf fuf fr]
             (unwrapo f uf)
             (flatteno uf fuf)
             (flatteno r fr)
             (cl/appendo fuf fr o)))
  ([l o]
   (unwrapo l o)))

(comment "Examples for usage of 'flatteno' (note: last one is a bug)"

  (cl/run* [q] (flatteno [1] q))

  (cl/run* [q] (flatteno [[1]] q))

  (cl/run* [q] (flatteno [[[1]]] q))

  (cl/run* [q] (flatteno [[1 2]] q))

  (cl/run* [q] (flatteno [[1] [2]] q))

  (cl/run* [q] (flatteno [[1 2] [3 4]] q))

  (cl/run* [q] (flatteno [[1] [2] [3]] q))

  (cl/run* [q] (flatteno [[1 [2]] [3] [4 5 6]] q))

  )

(cl/defne subseto
  "Checks to see if 'a' is a subset of 'l' using set semantics (i.e. repeated elements
   are only counted once)"
  [a l]
  ([() l])
  ([[f . r] l]
   (cl/membero f l)
   (subseto r l)))

(comment "Examples for 'subseto'"

  (cl/run* [q] (fd/bounded-listo q 3) (subseto '(1 2) q))

  (cl/run* [q] (fd/bounded-listo q 3) (subseto '(2 2) q))

  )

(cl/defne disjoino
  "Removes all of the elements in 'xs' from 'l' and puts the results in 'o'"
  [xs l o]
  ([() l l])
  ([_ () ()])
  ([[f . r] _ _]
   (cl/fresh [dl]
             (cl/rembero f l dl)
             (disjoino r dl o))))

(comment "Examples for 'disjoino'"

  (cl/run* [q] (disjoino [1 2 3] [1 2 3 4 5] q))

  (cl/run* [q] (disjoino '() [1 2 3 4 5] q))

  (cl/run* [q] (disjoino [1 2 3] '() q))

  (cl/run* [q] (disjoino [1 2 3] [3 4 5] q))

  )

(cl/defne counto
  "Puts the upper bound for the size of 'l' in 'n'"
  [l n]
  ([() n]
   (fd/== n 0))
  ([[h . t] n]
   (cl/fresh [m]
             (fd/in m (fd/interval Integer/MAX_VALUE))
             (fd/+ m 1 n)
             (counto t m))))

(comment "Examples for counto"

  (cl/run* [q] (counto [1 2 3 4] q))

  (cl/run* [q] (counto q 3))

  )

(pl/db-rel imports ^:index package ^:index imports)

(defn imports-satisfiedo
  "Checks that all the necessary imports for 'a' are presesnt in 'l'"
  [a l]
  (cl/fresh [i]
            (imports a i)
            (subseto i l)))

(cl/defne all-imports-satisfiedo
  "Checks that all packages' imports are satisfied by other packages in the group"
  [l i]
  ([[h] i]
   (imports-satisfiedo h i))
  ([[h . t] i]
   (cl/distincto l)
   (imports-satisfiedo h i)
   (all-imports-satisfiedo t i)))

(cl/defne build-groupo
  "Given a set of groups already built 'gs' and a list of packages that need to be built
   'b', finds a self-consistant group of packages to build 'g' such that all imports are
  satisfied either by elements of the group or previously built groups"
  [g gs b]
  ([f () b]
   (cl/fresh [n]
             (counto b n)
             (fd/bounded-listo f n)
             (all-imports-satisfiedo f f)
             (subseto f b)))
  ([f gs b]
   (cl/fresh [n gsr is]
             (counto b n)
             (fd/bounded-listo f n)
             (flatteno gs gsr)
             (cl/appendo f gsr is)
             (all-imports-satisfiedo f is)
             (subseto f b))))

(comment "Examples (both passing and failing)"

  (pl/with-db packages
    (cl/run* [q]
            (build-groupo q [] ['a 'b 'c 'd 'e])))

  (pl/with-db packages
    (cl/run* [q]
            (build-groupo q [['a 'b 'c]] ['d 'e])))

  (pl/with-db packages
    (cl/run* [q]
            (build-groupo q [['d] ['a 'b 'c]] ['e])))

  (pl/with-db packages
    (cl/run* [q]
            (build-groupo ['d 'e] [] ['a 'b 'c 'd 'e])))

  (pl/with-db packages
    (cl/run* [q]
            (build-groupo [] [['a 'b 'c]] ['d 'e])))

  (pl/with-db packages
    (cl/run* [q]
            (build-groupo ['e] [['d] ['a 'b 'c]] ['e])))

  (pl/with-db packages
    (cl/run* [q]
            (build-groupo '() '() '())))

)

(defn generate-build-order
  "Accepts a map that relates packages to a list of their imports. Returns a list of lists
   providing the order in which the packages should be built such that all interdependent
   imports are satisfied."
  [pkg-map]
  (let [pkgs (set (keys pkg-map))
        pkg-map (reduce (fn [m [k v]]
                          (assoc m k (vec (set/intersection pkgs (set v)))))
                        {}
                        pkg-map)
        pkg-db (reduce (fn [db [k v]]
                         (pl/db-fact db imports k v))
                       pl/empty-db
                       pkg-map)]
    (loop [order [] pkgs pkgs]
      (if-let [pkgs (seq pkgs)]
        (let [[next-group] (pl/with-db pkg-db
                             (cl/run 1 [q]
                                     (build-groupo q order pkgs)))
              order (conj order next-group)
              pkgs (apply disj (set pkgs) next-group)]
          (recur order pkgs))
        order))))

(comment

  (def pkg-map {"org.foo" ["org.bar"]
                "org.bar" ["org.foo" "org.baz"]
                "org.baz" ["org.foo"]
                "org.qux" ["org.foo"]
                "org.quux" ["org.bar" "org.qux"]})

  (generate-build-order pkg-map)

  )

(comment
  "Some more work on automating the process of resolving an entire build order using
   solely core logic. So far this doesn't work..."

  (def packages
    (pl/db [imports 'a ['b 'c]] [imports 'b ['c]] [imports 'c ['a]]
           [imports 'd ['a]] [imports 'e ['b 'd]]))

  (cl/defna build-ordero
    "Looks for a list of lists where all the elements of each list have their imports
     satisfied either by earlier elements in the list or by themselves."
    [l b]
    ([[f . r] _]
     (cl/fresh [fl e lb bd]
               (build-groupo f r b)
               (disjoino f b bd)
               (build-ordero r bd)))
    ([() [_]] cl/u#)
    ([() ()]))

  (pl/with-db packages
    (cl/run 1 [q]
            (build-ordero [] ['a 'b 'c 'd 'e])))

  (pl/with-db packages
    (cl/run 1 [q]
            (build-ordero [['d 'e 'a 'b 'c]] ['a 'b 'c 'd 'e])))

  (pl/with-db packages
    (cl/run 1 [q]
            (build-ordero '() ['d])))

  (pl/with-db packages
    (cl/run 1 [q]
            (build-ordero [['a 'b 'c]] ['a 'b 'c 'd])))

  (pl/with-db packages
    (cl/run 1 [q]
            (build-ordero [['d 'e] ['a 'b 'c]] ['a 'b 'c 'd 'e])))

  (pl/with-db packages
    (cl/run 3 [q]
            (build-ordero q ['a 'b 'c 'd 'e])))

)


