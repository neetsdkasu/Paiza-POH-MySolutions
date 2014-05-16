#!/usr/bin/perl
# paiza POH! vol.2
# result:
# http://paiza.jp/poh/paizen/result/65cb7f2104cbaa627523285727875758
# author: Leonardone @ NEETSDKASU

@hw = split(' ', <STDIN>);
$h = int($hw[0]);
$w = int($hw[1]);

@sp;
@tb;
for $y (0 .. $h - 1) {
	@line = split('', <STDIN>);
	for $x (0 .. $w - 1) {
		if ($line[$x] == '0') {
			$sp[$x]++;
			$s = $sp[$x];
			$t = 1;
			for ($i = $x; $i >= 0 && $sp[$i] > 0; $i--) {
				if ($sp[$i] < $s) {
					$s = $sp[$i];
				}
				$tb[$s][$t]++;
				$t++;
			}
		} else {
			$sp[$x] = 0;
		}
	}
}

for $x (1 .. $w) {
	$tb[$h][$x] += 0;
	for ($y = $h - 1; $y > 0; $y--)  {
		$tb[$y][$x] += $tb[$y + 1][$x];
	}
}

$n = int(<STDIN>);
for (1 .. $n) {
	@st = split(' ', <STDIN>);
	$s = int($st[0]);
	$t = int($st[1]);
	if ($s <= $h && $t <= $w) {
		print $tb[$s][$t], "\n";
	} else {
		print "0\n";
	}
}
