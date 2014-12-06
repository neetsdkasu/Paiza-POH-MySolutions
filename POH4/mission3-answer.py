# coding: utf-8
(t, n) = [int(i) for i in raw_input().strip().split()]
maximum = 0
sum = 0
a = []
for i in xrange(n):
    m = int(raw_input())
    a.append(m)
    if i >= t:
       sum += m - a.pop(0) 
    else:
        sum += m
    if sum > maximum:
        maximum = sum
print maximum
