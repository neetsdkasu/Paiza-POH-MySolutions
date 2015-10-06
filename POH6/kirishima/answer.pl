#
# 結果 https://paiza.jp/poh/joshibato/kirishima/result/780c7219
# 
my $n = int(<STDIN>);
my @t = map(int, split(' ',<STDIN>));
my $m = int(<STDIN>);

for ($i = 0; $i < $m; $i++) {
    my $d = int(<STDIN>);
    my @f = map {false} 0 .. n;
    my $r = "No";
    for (;;) {
        if ($d < 1 || $d >= $n) {
            last;
        }
        if ($d == $n - 1) {
            $r = "Yes";
            last;
        }
        if ($t[$d] == 0) {
            last;
        }
        if ($f[$d]) {
            last;
        }
        $f[$d] = true;
        $d += $t[$d];
    }
    print("$r\n");
}
