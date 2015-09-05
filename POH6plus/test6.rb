f = Hash.new 0
g = {}
c = ""
a = Array.new 1001
i = 0
j = 1001
ARGF.read.split[1..-1].each { |x|
    y=g[x]=x.reverse
    f[x<y ? x : y] += 1
    x==y && c=x
}
f.keys.sort.each{|k|
    v=f[k]>>1
    a.fill(k, i, v)
    a.fill(g[k], j -= v, v)
    i+=v
} 
a[500] = c
s = ""
a.compact.each {|x| s += x}
$><< s
