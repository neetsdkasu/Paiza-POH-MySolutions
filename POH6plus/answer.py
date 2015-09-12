# coding: utf-8
n = int(raw_input())
w = [ raw_input() for i in xrange(n) ]
w.sort()
s = ""
c = ""
for i in xrange(n):
    if w[i] == "":
        continue
    r = w[i][::-1]
    if r in w[i+1:]:
        j = w.index(r,i+1)
        w[j] = ""
        s += w[i]
    elif w[i] == r and (len(c) == 0 or c > r):
        c = r
print s + c + s[::-1]
