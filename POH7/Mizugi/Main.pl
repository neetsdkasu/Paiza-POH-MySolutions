# Try POH
# author: Leonardone @ NEETSDKASU
# -----------------------------------------------------------------------------
sub gs { chomp(my $v = <>); $v }
sub gi { int gs }
sub gss { split / /, gs  }
sub gis { map int, gss }
sub ngt { my ($n, $f) = @_; my @r = (); for (1 .. $n) { push @r, &$f } @r }
sub ngs { ngt shift @_, \&gs }
sub ngi { ngt shift @_, \&gi }
sub ngss { ngt shift @_, sub { [&gss] } }
sub ngis { ngt shift @_, sub { [&gis] } }
# -----------------------------------------------------------------------------


sub solve {
    my $n = gi;
    my $r = 1;
    my $c = 0;
    for $x (1 .. $n) {
        while ($x % 5 == 0) {
            $x /= 5;
            $c--;
        }
        while ($x % 2 == 0) {
            $x /= 2;
            $c ++;
        }
        $r = ($r * $x) % 1000000000;
    }
    while ($c-- > 0) {
        $r = ($r * 2) % 1000000000
    }    
    print "$r\n";
}


solve;
