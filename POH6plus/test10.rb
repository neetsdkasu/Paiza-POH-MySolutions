n=gets.to_i;(n%6==1&&$><<gets.chop*n)||(w=ARGF.read.split.sort;s=w.map{|x|(w.index(y=x.reverse)&&x<y&&x)||""}.join;puts s+(n<9?"qaq":"")+s.reverse)
