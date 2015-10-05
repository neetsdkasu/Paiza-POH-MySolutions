;
; 結果 https://paiza.jp/poh/joshibato/tsubame/result/24209bda
;

(let [n   (Integer/parseInt (read-line))
      n1  (mod n 10)
      n10 (/ (- n n1) 10)
      r   (+ n n1 n10)
      ]
    (println r))
