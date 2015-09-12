gets;s=c="";w=ARGF.read.split.sort;w.map{|x|(x==y=x.reverse)&&c=x;x<y&&s+=x*w.count(y)};$><<s+c*w.count(c)+s.reverse
