# coding: utf-8
#
# 結果 https://paiza.jp/poh/joshibato/kirishima/result/fe240a30
#

n = int(input())
t = [x for x in map(int, input().split())]
m = int(input())

for i in range(m):
    d = int(input())
    f = [False for j in range(n)]
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
    print(r)
