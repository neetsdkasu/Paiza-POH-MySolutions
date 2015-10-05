# coding: utf-8
#
# 結果 https://paiza.jp/poh/joshibato/rio/result/62050e0a
#

n = int(raw_input())

w = 0.0
c = 0.0

for i in xrange(n):
    t, x = map(int, raw_input().split())
    s = float(x)
    if t == 1:
        w += s
    elif t == 2:
        c += s
    else:
        wc = w + c
        tw = (w * wc - s * w) / wc
        tc = (c * wc - s * c) / wc
        w = tw
        c = tc

ans = int(100.0 * c / (w + c))

print ans
