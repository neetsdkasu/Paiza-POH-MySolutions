#
# 結果 https://paiza.jp/poh/joshibato/kirishima/result/6d551afb
#

n = gets.to_i
t = gets.chomp.split.map &:to_i

gets.to_i.times do
    d = gets.to_i
    f = [false] * n
    r = "No"
    loop {
        break if d < 1 || d >= n
        (r = "Yes"; break) if d == n - 1
        break if t[d] == 0
        break if f[d]
        f[d] = true
        d += t[d]
    }
    puts r
end
