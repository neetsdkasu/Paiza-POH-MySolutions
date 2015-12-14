#! ruby
# Try POH
# author: Leonardone @ NEETSDKASU

def gs(); gets.chomp; end
def gi(); gets.to_i; end
def gss(); gs.split; end
def gis(); gss.map(&:to_i); end

x, y, z, n = gis

xm = x
ym = y
xs = [x]
ys = [y]

n.times do
    d, a = gis
    if d == 0
        xm = ([xm, a] + xs.map{|v|(v-a).abs}).min
        xs << a
    else
        ym = ([ym, a] + ys.map{|v|(v-a).abs}).min
        ys << a
    end
end

puts z * xm * ym
