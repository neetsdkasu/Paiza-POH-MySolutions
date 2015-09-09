gets;w=ARGF.read.split.sort;c=s="";k=0;w.map{|x|((x==y=x.reverse)&&(k+=1;c=x))||!w.index(y)||y<x||s+=x};$><<s+c*k+s.reverse
