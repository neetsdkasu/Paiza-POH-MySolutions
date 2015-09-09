gets;w=ARGF.read.split.sort;c=s="";w.map{|x|!w.index(y=x.reverse)||y<x||(x==y&&c=x)||s+=x};$><<s+c*w.count(c)+s.reverse
