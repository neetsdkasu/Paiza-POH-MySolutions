#include<cstdlib>
int main(){exit(system("perl -e '$n=int(<STDIN>);@a=();while(<>){chomp($_);push @a,$_;}@a=sort(@a);$w=join(\" \",@a);$c=\"\";for$k(@a){$r=reverse($k);if($k lt$r&&$w=~/$r/){$w=~s/$r//;}else{$c.=$k if$k eq$r;$w=~s/$k//;}}$w=~s/ //g;print $w.$c.reverse($w);'"));}
