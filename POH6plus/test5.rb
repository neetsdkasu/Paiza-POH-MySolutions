f,s=Hash.new(0),c="";gets.to_i.times{x=gets.chop;y=x.reverse;f[[x,y].min]+=1;x==y&&c=x;};f.sort.map{|k,v|(v/2).times{s+=k};};$><<s+c+s.reverse
