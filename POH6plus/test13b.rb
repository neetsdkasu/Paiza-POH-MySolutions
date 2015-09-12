gets;s=c="";w=ARGF.read.split.sort;w.map{|x|c=x if x==y=x.reverse;x<y&&w.index(y)&&s+=x};$><<s+c*w.count(c)+s.reverse
