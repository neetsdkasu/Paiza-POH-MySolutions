#! ruby
# Try POH
# author: Leonardone @ NEETSDKASU

def gs(); gets.chomp; end
def gi(); gets.to_i; end
def gss(); gs.split; end
def gis(); gss.map(&:to_i); end

n = gi

MD = 10 ** 9

r, b = (1..n).inject([1,0]) {|(r,b), v|
    (b += 1; v /= 2) while v%2==0
    (b -= 1; v /= 5) while v%5==0
    [r * v % MD, b]
}

b.times do
    r=r * 2 % MD
end

puts r
