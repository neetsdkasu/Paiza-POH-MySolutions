# coding: utf-8

(t, n) = [int(i) for i in input().split()]

sum = 0
a = [0] * n
for i in range(t):
    m = int(input())
    a[i] = m
    sum += m
maximum = sum
for i in range(t, n):
    m = int(input())
    a[i] = m
    sum += m - a[i - t]
    if sum > maximum:
        maximum = sum
print(maximum)
