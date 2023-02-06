<img src="https://i.imgur.com/GH71uSi.png" title="zalky" align="right" width="250"/>

# dbscan-clj

[![Clojars Project](https://img.shields.io/clojars/v/io.zalky/dbscan-clj?labelColor=blue&color=green&style=flat-square&logo=clojure&logoColor=fff)](https://clojars.org/io.zalky/dbscan-clj)

Simple [DBSCAN](https://en.wikipedia.org/wiki/DBSCAN) implementation
for Clojure/Clojurescript.

DBSCAN is a "density-based spatial clustering of applications with
noise". In practical terms, this means that given a set of
2-dimensional points, it will return those points clustered into a
number of groups, with an additional group of points that failed to
cluster called "noise". Make sure you understand the heuristics of the
DBSCAN algorithm to know whether it will perform well for your
particular problem.

Just include the following in your `deps.edn`:

```clj
{:deps {io.zalky/dbscan-clj {:mvn/version "0.1.0"}}}
```

## Usage

Given a set of two dimensional points, all of which must have an id,
and a pair of x and y coordinates:

```clj
(def points
  [{:system/id 1 :kr.coord/x 1 :kr.coord/y 0}
   {:system/id 2 :kr.coord/x 1 :kr.coord/y 0}
   {:system/id 3 :kr.coord/x 0 :kr.coord/y 1}
   {:system/id 4 :kr.coord/x 5 :kr.coord/y 7}
   {:system/id 5 :kr.coord/x 6 :kr.coord/y 7}])
```

You can cluster them into groups labelled from `1` onward:

```clj
(c/cluster points {:attrs {:id :system/id
                           :x :kr.coord/x
                           :y :kr.coord/y}
                   :min-points 2
                   :epsilon 1})

;; => 
{1      [{:system/id 1, :kr.coord/x 1, :kr.coord/y 0}
         {:system/id 2, :kr.coord/x 1, :kr.coord/y 0}]
 2      [{:system/id 4, :kr.coord/x 5, :kr.coord/y 7}
         {:system/id 5, :kr.coord/x 6, :kr.coord/y 7}]
 :noise [{:system/id 3, :kr.coord/x 0, :kr.coord/y 1}]}
```

Here we have two groups numbered `1` and `2`. Points that did not
cluster will appear in a separate group called `:noise`. The semantics
of `:noise` is that there is no relationship between the points: they
are just returned together for convenience.

#### Parameters `:epsilon` and `:min-points`

The behaviour of the DBSCAN algorithm is highly dependent on the two
parameters `:epsilon` and `:min-points`. For general clustering
applications, the choice of these two parameters is very context
dependent.

However, for most 2-dimensional spatial clustering problems, one
recommendation is to take `:epsilon` to be a distance beyond which
points should not easily cluster, and `:min-points` to be the desired
minimum cluster size. Then you should see how your initial estimate of
these parameters performs on your data set and tune them from there.

## License

dbscan-clj is distributed under the terms of the Apache License 2.0.
