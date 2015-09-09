gets;w=ARGF.read.split.sort;c=s="";w.map{|x|!w.index(y=x.reverse)||(x==y&&c=x)||x<y&&s<<x};$><<s+c*w.count(c)+s.reverse
