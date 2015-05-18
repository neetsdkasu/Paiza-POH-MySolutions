;; 15 puzzle solver
;; 2015-05-18
;; Leonardone @ NEETSDKASU
;;
;; ググったら15パズルにはA*アルゴリズムを使えと書いてあった

(def Puzzle-Default '(0x123456789abcdef0 0xf 0))

(defn Puzzle-Shift [i] (- 60 (bit-shift-left i 2)))

(defn Puzzle-GetIndex [dt n]
	(loop [d dt x 0]
		(if (== d 0) (+ x (if (== n 0) 15 0))
			(let [v (bit-and d 0xf)]
				(if (== v n) (+ x 15) (recur (bit-shift-right d 4) (dec x))))
			)))

(defn Puzzle-GetNumber [dt i]
	(bit-and (bit-shift-right dt (Puzzle-Shift i)) 0xf))

(defn Puzzle-SetNumber [dt i n]
	(let [sh (Puzzle-Shift i)]
		(bit-or (bit-and dt (bit-not (bit-shift-left 0xf sh))) (bit-shift-left (bit-and n 0xf) sh))))

(def Puzzle-CostMap
	(let [abs (fn [a] (if (< a 0) (- a) a))]
		(loop [m (assoc (hash-map) 0 0) i 0 n 0]
			(if (>= n 15) m
				(let [x (abs (- (bit-and i 3) (bit-and n 3)))
					y (abs (- (bit-shift-right i 2) (bit-shift-right n 2)))]
					(recur (assoc m (Puzzle-SetNumber 0 i (inc n)) (* (+ x y) 3)) 
						(bit-and (inc i) 15) (if (== i 15) (inc n) n))
				)))))

(defn Puzzle-CalcCost [d]
	(apply + (for [i (range 16)] (Puzzle-CostMap (bit-and d (bit-shift-left 0xf (Puzzle-Shift i)))))))

(defn Puzzle-Make [x] (list x (bit-shift-left 0xf (Puzzle-Shift (Puzzle-GetIndex x 0))) (Puzzle-CalcCost x)))

(defn Puzzle-Data [x] (first x))
(defn Puzzle-Zero [x] (second x))
(defn Puzzle-Cost [x] (nth x 2))

(defn Puzzle-NumberOf [p i] (Puzzle-GetNumber (Puzzle-Data p) i))
(defn Puzzle-IndexOf [p n] (Puzzle-GetIndex (Puzzle-Data p) n))

(defn Puzzle-Print [p] 
	(println "---------------")
	(dotimes [i 16]
		(let [b (bit-and i 3) v (Puzzle-NumberOf p i)]
			(if (> b 0) (print " "))
			(if (== v 0) (print " *") (printf "%2d" v))
			(if (= b 3) (println))
		)))

(defn Puzzle-MoveLeft [p]
	(let [z (Puzzle-Zero p)]
		(if (< z 0) p
			(if (> (bit-and z 0x0000f000f000f000) 0) p
				(let [d (Puzzle-Data p) z2 (bit-shift-left z 4) n2 (bit-and z (bit-shift-right d 4))]
					(list (bit-or (bit-and d (bit-not z2)) n2) z2 
						(+ (Puzzle-Cost p) (- (Puzzle-CostMap n2) (Puzzle-CostMap (bit-and d z2)))))
				)))))

(defn Puzzle-MoveRight [p]
	(let [z (Puzzle-Zero p)]
		(if (> (bit-and z 0x000f000f000f000f) 0) p
			(let [d (Puzzle-Data p) z2 (if (< z 0) 0x0f00000000000000 (bit-shift-right z 4)) n2 (bit-shift-left (bit-and d z2) 4)]
				(list (bit-or (bit-and d (bit-not z2)) n2) z2
					(+ (Puzzle-Cost p) (- (Puzzle-CostMap n2) (Puzzle-CostMap (bit-and d z2)))))
			))))

(defn Puzzle-MoveUp [p]
	(let [z (Puzzle-Zero p)]
		(if (< z 0) p
			(if (> (bit-and z 0x0fff000000000000) 0) p
				(let [d (Puzzle-Data p) z2 (bit-shift-left z 16) n2 (bit-and z (bit-shift-right d 16))]
					(list (bit-or (bit-and d (bit-not z2)) n2) z2
						(+ (Puzzle-Cost p) (- (Puzzle-CostMap n2) (Puzzle-CostMap (bit-and d z2)))))
				)))))

(defn Puzzle-MoveDown [p]
	(let [z (Puzzle-Zero p)]
		(if (> (bit-and z 0x000000000000ffff) 0) p
			(let [d (Puzzle-Data p) z2 (if (< z 0) 0x0000f00000000000 (bit-shift-right z 16)) n2 (bit-shift-left (bit-and d z2) 16)]
				(list (bit-or (bit-and d (bit-not z2)) n2) z2
					(+ (Puzzle-Cost p) (- (Puzzle-CostMap n2) (Puzzle-CostMap (bit-and d z2)))))
			))))

(defn Puzzle-Move [p k]
	(([Puzzle-MoveLeft Puzzle-MoveRight Puzzle-MoveUp Puzzle-MoveDown] (bit-and k 3)) p))

(defn Puzzle-MoveNumber [p n]
	(let [v (- (Puzzle-IndexOf p n) (Puzzle-IndexOf p 0))]
		(cond
			(= v -1) (Puzzle-MoveLeft p)
			(= v 1) (Puzzle-MoveRight p)
			(= v -4) (Puzzle-MoveUp p)
			(= v 4) (Puzzle-MoveDown p)
			:else p)))

(defn Puzzle-Shuffle [pz cnt]
	(loop [p pz c cnt]
		(if (<= c 0) p
			(recur (Puzzle-Move p (rand-int 4)) (dec c)))))

(defn Puzzle-MakeState [pz cnt pa] (list pz cnt pa))
(defn Puzzle-GetPuzzle [st] (first st))
(defn Puzzle-GetCount [st] (second st))
(defn Puzzle-GetParent [st] (nth st 2))
(defn Puzzle-GetValue [st] (+ (Puzzle-Cost (Puzzle-GetPuzzle st)) (Puzzle-GetCount st)))

(defn Puzzle-Solve-Move [op cl nx pz dt cnt1]
	(loop [o op c cl n nx k 0]
		(if (>= k 4)
			(list false o c n)
			(let [mpz (Puzzle-Move pz k) mdt (Puzzle-Data mpz) mst (Puzzle-MakeState mpz cnt1 dt)  mval (Puzzle-GetValue mst)]
				(if (== mdt dt)
					(recur o c n (inc k))
					(if (== mdt (Puzzle-Data Puzzle-Default))
						(list true (assoc o mdt mst) c n)
						(if (contains? o mdt)
							(if (< mval (Puzzle-GetValue (o mdt)))
								(let [st2 (o mdt) dt2 (Puzzle-GetPuzzle st2) v2 (Puzzle-GetValue st2)
										n2 (assoc n v2 (dissoc (n v2) dt2))]
									(recur (assoc o mdt mst) c (assoc n2 mval (assoc (n2 mval) mdt mst)) (inc k)))
								(recur o c n (inc k)))
							(if (contains? c mdt)
								(if (< mval (Puzzle-GetValue (c mdt)))
									(recur (assoc o mdt mst) (dissoc c mdt) (assoc n mval (assoc (n mval) mdt mst)) (inc k))
									(recur o c n (inc k)))
								(if (contains? n mval)
									(recur (assoc o mdt mst) c (assoc n mval (assoc (n mval) mdt mst)) (inc k))
									(recur (assoc o mdt mst) c (assoc n mval (assoc (hash-map) mdt mst)) (inc k)))
							))))))))



(defn Puzzle-Solve-Mins [opmap clmap nxmap minval minmap minlst]
	(loop [lst minlst 
			op (loop [o opmap m minlst] (if (nil? m) o (recur (dissoc o (first m)) (next m)))) 
			cl (merge clmap minmap) 
			nx (dissoc nxmap minval)]
		(if (nil? lst)
			(list false op cl nx)
			(let [st (minmap (first lst)) 
					pz (Puzzle-GetPuzzle st) 
					x (Puzzle-Solve-Move op cl nx pz (Puzzle-Data pz) (inc (Puzzle-GetCount st)))]
				(if (first x)
					(list true (nth x 1) (nth x 2) (nth x 3))
					(recur (next lst) (nth x 1) (nth x 2) (nth x 3))
				))
		)))



(defn Puzzle-Solve [pb]
	;;(Puzzle-Print pb)
	(let [pbst (Puzzle-MakeState pb 0 0) pbdt (Puzzle-Data pb) pbval (Puzzle-Cost pb)]
	(if (== pbdt (Puzzle-Data Puzzle-Default))
		()
		(loop [opmap (assoc (hash-map) pbdt pbst)  clmap (hash-map) nxmap (assoc (hash-map) pbval (assoc (hash-map) pbdt pbst))]
			(let [minval (first (sort (keys nxmap))) minmap (nxmap minval) minlst (keys minmap)
					y (Puzzle-Solve-Mins opmap clmap nxmap minval minmap minlst)
					res (nth y 0) op (nth y 1) cl (nth y 2) nx (nth y 3)]
				(if res
					(loop [a () st (op (Puzzle-Data Puzzle-Default))]
						(let [pz (Puzzle-GetPuzzle st) pa (Puzzle-GetParent st) i (Puzzle-GetIndex pa 0)]
							(if (== pa 0) a
								(if (contains? op pa)
									(recur (conj a (Puzzle-NumberOf pz i)) (op pa))
									(recur (conj a (Puzzle-NumberOf pz i)) (cl pa))
					))))
					(recur op cl nx))
			))
	)))


(defn Puzzle-Input []
	(loop [i 0 d 0]
		(if (>= i 4)
			(Puzzle-Make d)
			(let [s (clojure.string/split (read-line) #" ")
					t (loop [j 0 dd d]
						(if (>= j 4) dd
							(let [p (s j)]
								(if (== (compare p "*") 0)
									(recur (inc j) dd)
									(recur (inc j) (Puzzle-SetNumber dd (+ (* i 4) j) (Long/parseLong p)))
								))))]
				(recur (inc i) t)))))
							
					
(defn main []
	;;(loop [r (Puzzle-Solve (Puzzle-Shuffle Puzzle-Default 200))]
	(loop [r (Puzzle-Solve (Puzzle-Input))]
		(if (empty? r) nil
			(let [n (peek r)]
				(println n)
				(recur (pop r))))))


(main)
