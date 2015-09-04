f,s=Hash.new(0),c=""
gets.to_i.times{f[gets.chop]+=1}
f.keys.sort.map{|x|y=x.reverse
m,f[x]=[f[x],f[y]].min,0
c,m=x,m/2 if x==y
m.times{s+=x}}
$><<s+c+s.reverse
