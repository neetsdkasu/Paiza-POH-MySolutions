<?php
    /*
     * 結果 https://paiza.jp/poh/joshibato/kirishima/result/8b5b3816
     */
    function gets() { return trim(fgets(STDIN)); }
    $n = intval(gets());
    $t = array_map("intval", split(" ", gets()));
    $m = intval(gets());
    for ($i = 0; $i < $m; $i++) {
        $d = intval(gets());
        $f = array_fill(0, n, false);
        $r = "No";
        for (;;) {
            if ($d < 1 || $d >= $n) break;
            if ($d == $n - 1) {
                $r = "Yes";
                break;
            }
            if ($t[$d] == 0) break;
            if ($f[$d]) break;
            $f[$d] = true;
            $d += $t[$d];
        }
        echo $r.PHP_EOL;
    }
