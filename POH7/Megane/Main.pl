# Try POH
# author: Leonardone @ NEETSDKASU
# -----------------------------------------------------------------------------
# use List::Util qw(min max);
# -----------------------------------------------------------------------------
sub gs { chomp(my $s = <>); $s }
sub gi() { int(gs) }
sub gss() { split(/ /, gs)  } #  関数名の後の()はプロトタイプで、 ()をつけるとinline展開されるらしい
sub gis() { map(int, gss) }
sub ngt(&$) { my ($f, $n) = @_; my @r; for (1 .. $n) { push @r, &$f } @r } # プロトタイプをつけなくても引数に関数を渡せるが、ブロック渡しはプロトタイプ必要
sub ngs { ngt \&gs, shift }
sub ngi($) { ngt(\&gi, shift) } #なんとなくプロトタイプをつけてみた、$や@などの変数のタイプ記号を並べるらしい
sub ngss { ngt sub { [gss] }, shift }  # ラムダっぽい動的関数渡し
sub ngis { ngt { [gis] } shift } # ブロック渡し
sub isort { sort {$a <=> $b} @_ } # sort関数内で動的スコープの$aと$bが定義されるからブロック渡しで参照できるとのこと
sub disp2d { for my $y (@_) { for my $x (@{$y}) { print "$x," } print "\n" } }
# -----------------------------------------------------------------------------



sub solve {
    my $n = gi;
    my @p = ngs $n;
    my $m = gi;
    my $q = join '', ngs $m;
    for my $i (0 .. $n - $m) {
        for my $j (0 .. $n - $m) {
            my $u = join '', map { substr $_, $j * 2, $m * 2 - 1 } @p[$i .. $i + $m - 1];
            if ($q eq $u) {
                print "$i $j\n"
            }
        }
    }
}


solve
