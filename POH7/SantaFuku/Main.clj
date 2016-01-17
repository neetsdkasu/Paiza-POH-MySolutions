; Try POH
; author: Leonardone @ NEETSDKASU
(def gs read-line)
(defn gi [] (read-string (gs)))
(defn gss [] (list* (.split (gs) " "))) ; gisのmapがlistを返すのでgssも揃える
(defn gis [] (map read-string (gss)))
(defn ngt [n f] (reverse (loop [c n r []] (if (= c 0) r (recur (dec c) (cons (f) r))))))  ; forやmapだと遅延評価で読み込み順が狂うう
(defn ngs [n] (ngt n gs))
(defn ngi [n] (ngt n gi))
(defn ngss [n] (ngt n gss))
(defn ngis [n] (ngt n gis))
; ============================================

(defn minval [vs v]
    (let [vss (sort vs)]
        (first (reduce (fn [[r b] e] [(min r (- e b)) e]) [v 0] vss))
    ))
(defn solve [x y z da]
    (let [buildf (fn [[xs ys] [d a]] (if (= d 0) [(cons a xs) ys] [xs (cons a ys)]))
          [xs ys] (reduce buildf [[x] [y]] da)
          xmin (minval xs x)
          ymin (minval ys y)
          ]
        (* xmin ymin z)
    ))

; ============================================

(defn main []
    (let [[x y z n] (gis)
          da (ngis n)
          ans (solve x y z da)]
        (println ans)
    ))

; ============================================
(main)
; ============================================
