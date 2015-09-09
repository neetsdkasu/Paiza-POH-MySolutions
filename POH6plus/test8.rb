gets;w=ARGF.read.split.sort;c=s="";k=0;w.map{|x|y=x.reverse;(x==y&&(c=x)&&k+=1)||!w.index(y)||y<x||s<<x};$><<s+c*k+s.reverse
