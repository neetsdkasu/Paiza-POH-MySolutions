gets;c=s="";w=ARGF.read.split.sort;w.map{|x|c+=x if x==y=x.reverse;x<y&&s+=x*w.count(y)};$><<s+c+s.reverse
