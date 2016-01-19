# Try POH
# author: Leonardone @ NEETSDKASU
# -----------------------------------------------------------------------------
sub gs { chomp(my $s = <>); $s }
sub gi { int gs }
sub gss { split / /, gs  }
sub gis { map int, gss }
sub ngt { my ($n, $f) = @_; my @r = (); for (1 .. $n) { push @r, &$f } @r }
sub ngs { ngt shift @_, \&gs }
sub ngi { ngt shift @_, \&gi }
sub ngss { ngt shift @_, sub { [gss] } }
sub ngis { ngt shift @_, sub { [gis] } }
sub min { my $v = pop @_; for $x (@_) { if ($x < $v) { $v = $x} } $v }
sub max { my $v = pop @_; for $x (@_) { if ($x > $v) { $v = $x} } $v }
sub isort { sort {$a <=> $b} @_ }
# -----------------------------------------------------------------------------


sub solve {
    my ($x, $y, $z, $n) = gis;
    my @xs = (0, $x);
    my @ys = (0, $y);
    for (ngis $n) {
        my ($d, $a) = @{$_};
        if ($d == 0) {
            push @xs, $a;
        } else {
            push @ys, $a;
        }
    }
    sub minval {
        my $v = shift @_;
        my $p = shift @_;
        for $w (@_) {
            $v = min $v, $w - $p;
            $p = $w
        }
        $v;
    }
    $x = minval($x, isort @xs);
    $y = minval($y, isort @ys);
    my $ans = $x * $y * $z;
    print "$ans\n";
}

solve;
