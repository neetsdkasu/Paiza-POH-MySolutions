gets;w=$<.read.split;s=w.select{|x|w.index(y=x.reverse)&&x<y}.sort*"";$><<s+w.select{|x|x==x.reverse}*""+s.reverse
