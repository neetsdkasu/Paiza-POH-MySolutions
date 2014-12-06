# coding: utf-8
(t, n) = [int(i) for i in raw_input().strip().split()]
sum = 0
a = [0] * n
for i in xrange(t):
    m = int(raw_input())
    a[i] = m
    sum += m
maximum = sum
for i in xrange(t, n):
    m = int(raw_input())
    a[i] = m
    sum += m - a[i - t]
    if sum > maximum:
        maximum = sum
print maximum
