<?php
$w = [];
for ($i = fgets(STDIN) - 0; $i > 0; $i--) {
    $x = trim(fgets(STDIN));
    if (isset($w[$x])) 
        $w[$x]++; 
     else 
        $w[$x] = 1;
}
ksort($w);
$s= $c = '';
foreach ($w as $k => &$v) {
    $r = strrev($k);
    if (empty($w[$r]))
        continue;
    $m = min($v, $w[$r]);
    $v = 0;
    if ($k == $r) {
        if ($m % 2 == 1 && (empty($c) || $k < $c))
            $c = $k;
        $m >>= 1;
    }
    $s .= str_repeat($k, $m);
}
echo $s . $c . strrev($s), PHP_EOL;
