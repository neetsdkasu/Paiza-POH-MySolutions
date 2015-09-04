f=Hash.new(0)
s=c=""
gets.to_i.times{f[gets.chop]+=1}
f.keys.sort.each{|x|y=x.reverse
m=[f[x],f[y]].min
f[x],b=0,x==y
c,m=x,m-1if b&&m.odd?&&(c==""||c<x)
b&&m/=2
m.times{s+=x}}
$><<s+c+s.reverse
