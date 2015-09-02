f,c,s,w=Hash.new(0),[],"",readlines[1..-1].map{|x|x.chop}
w.each{|x|f[x]+=1}.sort.map{|x|next if f[x]<1
y=x.reverse
if x==y&&f[x]<2
c+=[x]
f[x]-=1
elsif f.key?y and f[y]>0
s+=x
f[x]-=1
f[y]-=1
end}
puts s+(c.size>0?c.sort[0]:"")+s.reverse
