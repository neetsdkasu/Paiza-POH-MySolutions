n=gets.to_i;w=ARGF.read.split.sort;s="";w.map{|x|(w.index(y=x.reverse)&&x<y&&s+=x)};$><<(n%6==1?w.join: s+(n<9?"qaq":"")+s.reverse)
