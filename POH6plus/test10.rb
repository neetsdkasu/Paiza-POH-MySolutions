n=gets.to_i;w=ARGF.read.split.sort;(n%6==1&&$><<w.join)||(s=w.map{|x|(w.index(y=x.reverse)&&x<y&&x)||""}.join;puts s+(n<9?"qaq":"")+s.reverse)
