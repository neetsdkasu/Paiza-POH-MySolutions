<?php
    /*
     * 結果 https://paiza.jp/poh/joshibato/tsubame/result/c5bc86af
     */
    $n_str = fgets(STDIN);
    
    $n = intval($n_str);
    $n1 = intval($n_str[1]);
    $n10 = intval($n_str[0]);
    $r = $n + $n1 + $n10;
    
    echo $r.PHP_EOL;
    
