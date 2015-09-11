#!/usr/bin/perl

my $n=int(<STDIN>);
my @a=();
for (my $i=0;$i<$n;$i++) {
	chomp(my $w=<STDIN>);
	push @a, $w;
}
@a=sort @a;

my $s = "";
my $c = "";

for (my $i=0; $i<$n; $i++) {
	if ($a[$i] eq "") {
		next;
	}
	my $r=reverse($a[$i]);
	for (my $j=$i+1; $j<$n; $j++){
		if ($a[$j] eq $r) {
			$a[$j]="";
			$s.=$a[$i];
			$r="";
			last;
		}
	}
	if ($a[$i] eq $r && ($c eq "" || $c gt $r)) {
		$c=$r;
	}
}

print $s.$c.reverse($s);

