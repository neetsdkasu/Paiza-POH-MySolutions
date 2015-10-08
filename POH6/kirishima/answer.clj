;
; 結果 https://paiza.jp/poh/joshibato/kirishima/result/ef4cc2c8
;

(let [  n (Integer/parseInt (read-line))
        t (map #(Integer/parseInt %) (clojure.string/split (read-line) #" "))
        m (Integer/parseInt (read-line))
        ]
    (println (clojure.string/join "\n"
        (for [i (range m)]
            (loop [d (Integer/parseInt (read-line)) tf () tb t]
                (let [f (first tf) fs (rest tf) b (first tb) bs (rest tb)]
                    (cond
                        (and (< d 1) (empty? tf)) "No"
                        (empty? bs) (if (> d 0) "No" "Yes")
                        (> d 0) (recur (dec d) (cons b tf) bs)
                        (< d 0) (recur (inc d) fs (cons f tb))
                        :else (if (= b 0) "No" (recur b tf (cons 0 bs)))
                    ))))))
    )
        
