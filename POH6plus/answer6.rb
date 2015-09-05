f=Hash.new 0;s=c="";gets.to_i.times{f[gets.chop]+=1};f.sort.map{|x,m|y=x.reverse;m,f[x],b=[m,f[y]].min,0,x==y;c,m=x,m-1if(c==""||x<c)&b&m.odd?;b&&m/=2;s+=x.*m};$><<s+c+s.reverse
