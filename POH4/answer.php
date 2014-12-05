<?php
    function input() { return fgets(STDIN); }
    function int($v) { return intval($v); }
    function calc2($str) {
        $str = split(" ", $str);
        $t = int($str[0]);
        $s = int($str[1]);
        $p = int($str[2]);
        return ($t > $s) ? ($t - $s) * $p : 0;
    }
   
    $str = input();
   
    $c = 0;

    if (strpos($str, " ") > 0) {
        // mission3
        $str = split(" ", $str);
        $t = int($str[0]);
        $n = int($str[1]) - $t;
        $arr = array();
        for ($i = 0; $i < $t; $i++) {
            $arr[$i] = int(input());
            $c += $arr[$i];
        }
        $tmp = $c;
        $i = 0;
        while ($n-- > 0) {
            $tmp -= $arr[$i];
            $arr[$i] = int(input());
            $tmp += $arr[$i];
            if ($tmp > $c) {
                $c = $tmp;
            }
            $i = ($i + 1) % $t;
        }
    } else {
        $n = int($str) - 1;
       
        if ($n < 0) die("0");
        $str = input();
        if (strpos($str, " ") > 0) {
            // mission2
            $c += calc2($str);
            while ($n-- > 0) {
                $c += calc2(input());
            }
        } else {
            // mission1
            $c += int($str);
            while ($n-- > 0) {
                $c += int(input());
            }
        }
    }
    echo $c;
?>
