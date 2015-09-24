_,*w=$<.read.split.sort;c="";s=w.select{|x|c+=x if x==y=x.reverse;x<y&&w.index(y)}*"";$><<s+c+s.reverse
