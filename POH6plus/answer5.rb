f,s,c=Hash.new(0),[],""
gets.to_i.times{f[gets.chop]+=1}
f.keys.sort.each{|x|y=x.reverse
m=[f[x],f[y]].min
f[x]=0
if x==y
c,m=x,m-1if m.odd?&&(c==""||c<x)
m/=2
end
m.times{s+=[x]}}
t=s.join
$><<t+c+t.reverse
