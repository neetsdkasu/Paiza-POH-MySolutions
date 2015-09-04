f,s=Hash.new(0),c=""
gets.to_i.times{f[gets.chop]+=1}
f.keys.sort.map{|x|y=x.reverse
m,f[x],b=[f[x],f[y]].min,0,x==y
c,m=x,m-1if b&&(c==""||x<c)
b&&m/=2
m.times{s+=x}}
$><<s+c+s.reverse
