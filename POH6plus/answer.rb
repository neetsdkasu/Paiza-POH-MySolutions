n = gets.chomp.to_i
w = []
f = {}
c = []

n.times do
    x = gets.chomp
    w.push x
    if f.key? x then
        f[x] += 1
    else
        f[x] = 1
    end
end

w.sort!

s = ""

w.each do |x|
    if f.key? x then
        y = x.reverse
        if x == y and f[x] == 1 then
            c.push x
            f.delete x
        elsif f.key? y then
            s += x
            f[x] -= 1
            f[y] -= 1
            if f[x] < 1 then
                f.delete x
            end
            if f.key? y and f[y] < 1 then
                f.delete y
            end
        end
    end
end

if c.length > 0 then
    c.sort!
    s += c[0] + s.reverse
else
    s += s.reverse
end

puts s
