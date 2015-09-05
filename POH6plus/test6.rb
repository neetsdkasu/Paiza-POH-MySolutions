f = Hash.new 0
g = {}
c = ""
a = []
b = []
ARGF.read.split[1..-1].map{|x|
    f[[x,y=x.reverse].min] += 1;
    g[x] = y
    x==y&&c=y
}
f.sort.map{|k,v|
a += [k].*v>>1
b = ([g[k]].*v>>1) + b
}

$><<a.join+c+b.join
