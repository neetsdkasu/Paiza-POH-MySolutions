t, n = gets.chomp.split(" ").map! { |i| i.to_i }
v = Array.new(n, 0)
j, c, k = 0, 0, 0
if n < 10000 then
    s = readlines
else
    s = ARGF.read(nil).split($/)
end
s[0...t].each do |i|
    i = i.to_i
    v[j] = i
    c += i
    j += 1
end
m = c
s[t...n].each do |i|
    i = i.to_i
    v[j] = i
    c += i - v[k]
    if c > m then
        m = c
    end
    j += 1
    k += 1
end
puts m
