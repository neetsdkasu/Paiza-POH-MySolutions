
f=Hash.new 0
s=c=""
gets.to_i.times{f[gets.chop]+=1}
f.sort.map{|x,m|y=x.reverse
m,f[x],b=[m,f[y]].min,0,x==y
c,m=x,m-1if b&&m.odd?&&(c==""||x<c)
b&&m/=2
m.times{s+=x}}
$><<s+c+s.reverse
