gets;w=Hash.new e=0;w[$_.chop]+=1while gets;c="";s=w.sort.map{|k,v|(w[r=k.reverse]>0&&k<r&&k*v)||(k==r&&(c,e=k,v);"")}.join;$><<s+c*e+s.reverse
