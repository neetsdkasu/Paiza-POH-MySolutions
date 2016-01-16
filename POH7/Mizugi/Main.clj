; Try POH
; author: Leonardone @ NEETSDKASU

(def gs read-line)
(defn gi [] (read-string (gs)))
(defn gss [] (list* (.split (gs) " ")))
(defn gis [] (map read-string (gss)))
(defn ngt [n f] (for [_ (range n)] (f)))
(defn ngs [n] (ngt n gs))
(defn ngi [n] (ngt n gi))
(defn ngss [n] (ngt n gss))
(defn ngis [n] (ngt n gis))


(defn modval [v] (mod v 1000000000))
(defn reject [d v c]
    (loop [v v c c]
        (if (= (mod v d) 0) (recur (/ v d) (inc c))
            [v c]
        )))
(defn solve [n]
    (loop [v n r 1 c 0]
        (if (= v 1) (loop [r r c c] (if (= c 0) r (recur (modval (* r 2)) (dec c))))
            (let [[x c1] (reject 5 v 0)
                  [y c2] (reject 2 x (- c1))
                 ]
                (recur (dec v) (modval (* r y)) (+ c c2))
            ))))


(defn main []
    (let [n (gi) ans (solve n)]
        (println ans)
    ))


(main)
