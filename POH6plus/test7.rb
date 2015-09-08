c="";gets;a=readlines(())[k=0].split.sort;s=(a.dup.map{|x|y=x.reverse;x==y&&(c=x)&&k+=1;a.index(y)&&(a-=[x])&&x}-[c]).join;$><<s+c*k+s.reverse
