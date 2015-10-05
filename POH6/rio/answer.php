<?php
    /*
     * 結果 https://paiza.jp/poh/joshibato/rio/result/9eb646e4
     */
    $n = intval(fgets(STDIN));
    
    $w = 0.0;
    $c = 0.0;
    
    for ($i = 0; $i < $n; $i++) {
        fscanf(STDIN, "%d %f", $t, $s);
        switch ($t) {
        case 1: $w += $s; break;
        case 2: $c += $s; break;
        case 3:
            $tw = ($w * ($w + $c) - $s * $w) / ($w + $c);
            $tc = ($c * ($w + $c) - $s * $c) / ($w + $c);
            $w = $tw;
            $c = $tc;
            break;
        }
    }
    
    $ans = intval(100.0 * $c / ($w + $c));
    
    echo $ans.PHP_EOL;
