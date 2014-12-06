# coding: utf-8
(t, n) = [int(i) for i in raw_input().strip().split()]
maximum = 0
sum = 0
a = [0] * n
for i in xrange(n):
    m = int(raw_input())
    a[i] = m
    if i >= t:
       sum += m - a[i - t]
    else:
        sum += m
    if sum > maximum:
        maximum = sum
print maximum
