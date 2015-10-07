#
# 結果 https://paiza.jp/poh/joshibato/rio/result/d16074da
#

n = gets.to_i

w = 0.0
c = 0.0

n.times do
    t, s = gets.chomp.split.map &:to_i
    case t
    when 1
        w += s.to_f
    when 2
        c += s.to_f
    when 3
        wc = w + c
        w = (w * wc - s.to_f * w) / wc
        c = (c * wc - s.to_f * c) / wc
    end
end

ans = 100.0 * c / (w + c)

puts ans.floor
