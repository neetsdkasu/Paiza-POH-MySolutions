gets;w=ARGF.read.split.sort;c=s="";w.map{|x|c=x if x==y=x.reverse;!w.index(y)||y<=x||s+=x};$><<s+c*w.count(c)+s.reverse
