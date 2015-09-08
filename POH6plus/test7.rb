c="";k=0;a=readlines(())[0].split[1..-1].sort;z={};s=(a.map{|x|y=x.reverse;x==y&&(c=x)&&k+=1;(a.index(y)&&!z[y]&&z[x]=x)||""}-[c]).join;$><<s+(c*k)+s.reverse
