gets;c=s="";w=ARGF.read.split.sort;w.map{|x|w.index(y=x.reverse)&&x<y&&s+=x;x==y&&c=x};$><<s+w.grep(c).join+s.reverse
