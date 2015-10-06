# coding: utf-8
#
# 結果 https://paiza.jp/poh/joshibato/kirishima/result/8ca4f0ec
#

n = int(raw_input())
t = map(int, raw_input().split())
m = int(raw_input())

for i in xrange(m):
    d = int(raw_input())
    f = [False for j in xrange(n)]
    r = "No"
    while True:
        if d < 1 or d >= n: break
        if d == n - 1:
            r = "Yes"
            break
        if t[d] == 0: break
        if f[d]: break
        f[d] = True
        d += t[d]
    print r
