gets;w=ARGF.read.split.sort;c=s="";w.map{|x|w.index(y=x.reverse)&&x<y&&s+=x;x==y&&c=x};$><<s+c*w.count(c)+s.reverse
