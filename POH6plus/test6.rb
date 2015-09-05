f = Hash.new 0
g = {}
c = ""
a = Array.new(1001, "")
i = 0
j = 1001
ARGF.read.split[1..-1].map{|x|
    f[[x,y=x.reverse].min] += 1;
    g[x] = y
    x==y&&c=y
}
f.sort.map{|k,v|
a.fill(k, i, v>>1)
a.fill(g[k], j -= v>>1, v>>1)
i+=v>>1
}
a[500] = c
$><<a.join
