<?php
// paiza POH! Vol.1
// result:
// http://paiza.jp/poh/ec-campaign/result/f9f83f0dfa6a1a9390593c2f38277336
// author: Leonardone @ NEETSDKASU
$p = array();
function foo(&$p, $f, $e, &$m) {
	if (($df = $e - $f) < 5) return $e;
	if ($m < $p[$ci = ($f + ($df >> 1))]) {
		return foo($p, $f, $ci, $m);
	} else {
		return foo($p, $ci, $e, $m);
	}
}
function bar(&$p, $f, $e, &$m) {
	if (($df = $e - $f) < 5) return $f;
	if ($m > $p[$ci = ($f + ($df >> 1))]) {
		return bar($p, $ci, $e, $m);
	} else {
		return bar($p, $f, $ci, $m);
	}
}

$nd = explode(" ",fgets(STDIN));
$n = (int)$nd[0];
$d = (int)$nd[1];
for ($j=0;$j<$n;++$j) { $p[$j] = (int)fgets(STDIN); }
sort($p, SORT_NUMERIC);
--$n;
do {
	$m = (int)fgets(STDIN);
	$tmp = 0;
	$f = foo($p, 0, $n, $m);
	while ($p[$f] >= $m) --$f;
	if (($df = $m - $p[$f]) <= $p[$f]) {
		$e = bar($p, 0, $f, $df);
		do {
			while ($df > $p[$e]) ++$e;
			if (($df < $p[$e]) || ($f == $e)) if ($e > 0) --$e;
			if (($sum = $p[$f] + $p[$e]) > $tmp) {
				if ($sum <= $m) 
					if (($tmp = $sum) == $m) break;
			}
			--$f;
		} while (($df = $m - $p[$f]) <= $p[$f]);
	}
	echo $tmp, PHP_EOL;
} while (--$d);
