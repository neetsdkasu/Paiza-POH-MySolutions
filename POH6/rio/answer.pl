#
# 結果 https://paiza.jp/poh/joshibato/rio/result/1b22d471
#

my $n = int(<STDIN>);

my $w = 0.0;
my $c = 0.0;

for ($i = 0; $i < $n; $i++) {
    my ($t, $x) = split(' ', <STDIN>);
    $s = 1.0 * int($x);
    $w += $s if ($t == '1');
    $c += $s if ($t == '2');
    if ($t == '3') {
        $wc = $w + $c;
        $w = ($w * $wc - $s * $w) / $wc;
        $c = ($c * $wc - $s * $c) / $wc;
    }
}

$ans = int(100.0 * $c / ($w + $c));

print($ans);
