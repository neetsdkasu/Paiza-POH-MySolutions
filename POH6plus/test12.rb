gets;c=s="";h=Hash.new 0;(h[[$_.chop!,y=$_.reverse].min]+=1;$_==y&&c=y)while gets;h.sort.map{|k,v|s+=k.*v/2if v>1};$><<s+c+s.reverse
