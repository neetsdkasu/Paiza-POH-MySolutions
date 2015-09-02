c,s,w=[],"",readlines[1..-1].map{|x|x.chop}.sort.reverse
while w.size>0
x=w.pop
y=x.reverse
n=w.find_index y
if n.nil?
c+=[x]if x==y
else
s+=x
w.delete_at n
end
end
puts s+(c.size>0?c.sort[0]:"")+s.reverse
