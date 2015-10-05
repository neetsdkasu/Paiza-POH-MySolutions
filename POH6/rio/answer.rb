#
# 結果 https://paiza.jp/poh/joshibato/rio/result/05a630ce
#

n = gets.to_i

w = [0, 1]
c = [0, 1]

n.times {
    t, s = gets.chomp.split.map(&:to_i);   
    case t
    when 1; w = [w[0] + s * w[1], w[1]]
    when 2; c = [c[0] + s * c[1], c[1]]
    when 3;
        wc = w[1] == c[1] ? [w[0] + c[0], w[1]] : [w[0]*c[1]+c[0]*w[1], w[1]*c[1]]
        tws = [s * w[0] * wc[1], w[1] * wc[0]]
        tw = [w[0]*tws[1] - tws[0]*w[1], w[1]*tws[1]]
        tcs = [s * c[0] * wc[1], c[1] * wc[0]]
        tc = [c[0]*tcs[1] - tcs[0]*c[1], c[1]*tcs[1]]
        w = tw
        c = tc
    end
}

wc = w[1] == c[1] ? [w[0] + c[0], w[1]] : [w[0]*c[1]+c[0]*w[1], w[1]*c[1]]

ans = [100 * c[0] * wc[1], c[1] * wc[0]]

X = 1000000000000

ans = [ans[0] * X, ans[1] * X]

ans_n = ans[0] / ans[1]

puts ans_n


