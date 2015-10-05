# 結果 https://paiza.jp/poh/joshibato/tsubame/result/a47761cf
typeset -i n n1 n10 r; read n; n1=$(( n % 10 )); n10=$(( (n - n1) / 10 )); r=$(( n + n1 + n10 )); echo $r
