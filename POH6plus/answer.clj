(defn getnum [] (Long/parseLong (read-line)))
(defn getwords [n w] (if (= n 0) (sort w) (getwords (dec n) (conj w (read-line)))))
(defn seekword [w k]
    (if (empty? w) (list false nil) 
        (let [h (first w) t (rest w)]
            (if (= (compare k h) 0) (list true t) 
                (let [x (seekword t k)] (list (first x) (conj (second x) h)))
            ))))
(defn hoge [w s c]
    (if (empty? w) (list s c)
        (let [h (first w) t (rest w) k (clojure.string/reverse h) x (seekword t k) r (first x) a (second x)]
            (if r (hoge a (conj s h) c)
                (if (and (= (compare h k) 0) (or (clojure.string/blank? c) (< (compare h c) 0)))
                    (hoge t s h)
                    (hoge t s c)
                    )))))
(let [x (hoge (getwords (getnum) []) nil "") s (clojure.string/join (reverse (first x))) c (second x) r (list s c (clojure.string/reverse s))]
    (println (clojure.string/join r))
    )
