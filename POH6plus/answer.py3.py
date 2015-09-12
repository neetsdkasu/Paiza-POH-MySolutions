#! python3
# coding: utf-8
n = int(input())
w = [ input() for i in range(n) ]
w.sort()
s = ""
c = ""
for i in range(n):
    if w[i] == "":
        continue
    r = w[i][::-1]
    if r in w[i+1:]:
        j = w.index(r,i+1)
        w[j] = ""
        s += w[i]
    elif w[i] == r and (len(c) == 0 or c > r):
        c = r
print(s + c + s[::-1])
