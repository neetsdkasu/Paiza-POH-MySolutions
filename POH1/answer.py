# paiza POH! Vol.1
# result:
# http://paiza.jp/poh/ec-campaign/result/e6151191448a2d892579fb21f0f1a4bb
# author: Leonardone @ NEETSDKASU
nd = raw_input().split(" ")
n = int(nd[0])
d = int(nd[1])
p = []
for i in range(0, n):
    p.append(int(raw_input()))
p.sort()
ci = (n - 1) >> 1
cp = p[ci]
for i in range(0, d):
    m = int(raw_input())
    if m < cp:
        f = ci
    else:
        f = n - 1
    if m - p[ci] > cp:
        e = ci
    else:
        e = 0
    tmp = 0
    while f != e:
        sum = p[f] + p[e]
        if sum > m:
            f = f - 1
        else:
            if sum > tmp:
                tmp = sum
            e = e + 1
    print tmp
