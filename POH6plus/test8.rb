gets;w=ARGF.read.split.sort;c="";k=0;s=w.reject{|x|y=x.reverse;(x==y&&(c=x)&&k+=1)||!w.index(y)||x>y}.join;$><<s+c*k+s.reverse
