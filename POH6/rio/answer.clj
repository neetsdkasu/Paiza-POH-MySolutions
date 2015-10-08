;
; 結果 https://paiza.jp/poh/joshibato/rio/result/3ae0ce79
;

(loop [n (Integer/parseInt (read-line)) w 0.0 c 0.0]
    (if (= n 0) (println (int (Math/floor (/ (* 100.0 c) (+ w c)))))
        (let [  tas (clojure.string/split (read-line) #" ")
                t (Integer/parseInt (tas 0))
                s (Double/parseDouble (tas 1))
                ]
            (condp = t
                1   (recur (dec n) (+ w s) c)
                2   (recur (dec n) w (+ c s))
                3   (let [wc (+ w c)] 
                        (recur (dec n)
                            (/ (- (* w wc) (* s w)) wc)
                            (/ (- (* c wc) (* s c)) wc)
                            ))
                ))))
