<?php
// Try POH
// author: Leonardone @ NEETSDKASU

$n = intval(fgets(STDIN));

$r = 1;
$b = 0;

for ($i = 1; $i <= $n; $i++) {
    $x = $i;
    while ($x % 2 == 0) {
        $x /= 2;
        $b++;
    }
    while ($x % 5 == 0) {
        $x /= 5;
        $b--;
    }
    $r = ($r * $x) % 1000000000;
}

for ($i = 0; $i < $b; $i++) {
    $r = ($r * 2) % 1000000000;
}

echo $r, PHP_EOL;

