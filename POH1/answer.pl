#!/usr/bin/perl
# paiza POH! Vol.1
# result:
# http://paiza.jp/poh/ec-campaign/result/ffa7a20db886bcb77dafa63c1f23c8ef
# author: Leonardone @ NEETSDKASU
@nd = split(/ /,<STDIN>);
$n = int($nd[0]);
$d = int($nd[1]);
@p;
for ($i = 0; $i < $n; $i++) {
	$p[$i] = int(<STDIN>);
}
@p = sort {$a <=> $b} @p;
$ci = ($n - 1) >> 1;
$cp = $p[$ci];
for ($i = 0; $i < $d; $i++) {
	$m = int(<STDIN>);
	if ($m < $cp) {
		$f = $ci;
	} else {
		$f = $n - 1;
	}
	if ($m - $p[$f] > $cp) {
		$e = $ci;
	} else {
		$e = 0;
	}
	$tmp = 0;
	while ($f != $e) {
		$sum = $p[$f] + $p[$e];
		if ($sum > $m) {
			$f = $f - 1;
		} else {
			if ($sum > $tmp) {
				$tmp = $sum;
			}
			$e = $e + 1;
		}
	}
	print $tmp, "\n";
}
