(defn toint [n] (Integer/parseInt n))
(let [str (re-find #"(\d+) (\d+)" (read-line))
        t (toint (nth str 1))
        n (toint (nth str 2))
        maximum
        (loop [x 0 a (int-array n (int 0)) mx 0 c 0]
            (if (>= x n)
                (max mx c)
                (do
                    (aset-int a x (toint (read-line)))
                    (recur (inc x) a (
                        max c mx) 
                        (- (+ c (aget a x)) 
                            (if (>= x t) (aget a (- x t)) 0)
                            )
                        )
                )))]
    (println maximum) 
    )
