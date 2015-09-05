f = Hash.new(0)
c = ""
a = []
ARGF.read.split[1..-1].map{|x|f[[x,y=x.reverse].min]+=1;x==y&&c=y}
f.sort.map{|k,v|
a+=[k].*v/2
}
s=a.join
$><<s+c+s.reverse
