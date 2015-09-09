f=Hash.new 0;s=c="";gets;(f[[x=$_.chop,y=x.reverse].min]+=1;x==y&&c=x)while gets;f.sort.map{|k,v|s+=k.*v/2};$><<s+c+s.reverse
