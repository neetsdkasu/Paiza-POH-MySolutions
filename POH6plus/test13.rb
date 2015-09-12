gets;h=Hash.new 0;s=c="";w=ARGF.read.split.sort;w.map{|x|((x==y=x.reverse)&&c=x)||h[[x,y].min]=w.count(y)};h.map{|k,v|s+=k.*v};$><<s+c*w.count(c)+s.reverse
