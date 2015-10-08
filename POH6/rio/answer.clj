;
; 結果 https://paiza.jp/poh/joshibato/rio/result/48e53fba
;

(loop [n (Integer/parseInt (read-line)) w 0.0 c 0.0]
    (if (= n 0) (println (int (Math/floor (/ (* 100.0 c) (+ w c)))))
        (let [  tas (clojure.string/split (read-line) #" ")
                t (Integer/parseInt (tas 0))
                s (Double/parseDouble (tas 1))
                ]
            (cond
                (= t 1) (recur (dec n) (+ w s) c)
                (= t 2) (recur (dec n) w (+ c s))
                :else 
                    (let [wc (+ w c)] 
                        (recur (dec n)
                            (/ (- (* w wc) (* s w)) wc)
                            (/ (- (* c wc) (* s c)) wc)
                            ))
                ))))
