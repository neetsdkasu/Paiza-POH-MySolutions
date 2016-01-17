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

(defn solve [n p m q]
    (let [nm (+ (- n m) 1)
          nmr (range nm)
          cs (for [i (range nm) j (range nm)] (map #(take m (drop j %)) (take m (drop i p))))
          ln (count (take-while #(not (= q %)) cs))
          y (quot ln nm)
          x (rem ln nm)
          ]
        [y x]
    ))

; ============================================
(defn main []
    (let [n (gi)
          p (ngis n)
          m (gi)
          q (ngis m)
          [y x] (solve n p m q)
          ]
        (println y x)
    ))

; ============================================
(main)
; ============================================
