<?php
// paiza POH! vol.2
// result:
// http://paiza.jp/poh/paizen/result/8afab308477ce5e7f61b8a83b9d383ca
// author: Leonardone @ NEETSDKASU

fscanf(STDIN, "%d %d", $h, $w);

$table = array();
$space2top = array_fill(0, $w, 0);
for ($y = 0; $y <= $h; $y++) {
	$table[$y] = array_fill(0, $w + 1, 0);
}

for ($y = 0; $y < $h; $y++) {
	fscanf(STDIN, "%s", $str);
	for ($x = 0; $x < $w; $x++) {
		if ($str[$x] == '0') {
			$space2top[$x]++;
			$s = $space2top[$x];
			$t = 1;
			for ($i = $x; $i >= 0 && $space2top[$i] > 0; $i--) {
				if ($space2top[$i] < $s) {
					$s = $space2top[$i];
				}
				$table[$s][$t]++;
				$t++;
			}
		} else {
			$space2top[$x] = 0;
		}
	}
}

for ($x = 1; $x <= $w; $x++) {
	for ($y = $h - 1; $y > 0; $y--) {
		$table[$y][$x] += $table[$y + 1][$x];
	}
}

fscanf(STDIN, "%d", $n);

for ($i = 0; $i < $n; $i++) {
	fscanf(STDIN, "%d %d", $s, $t);
	if ($s <= $h && $t <= $w) {
		echo $table[$s][$t], PHP_EOL;
	} else {
		echo '0', PHP_EOL;
	}
}
