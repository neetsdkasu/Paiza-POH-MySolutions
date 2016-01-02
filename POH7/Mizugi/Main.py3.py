# coding: utf-8
# Try POH
# author: Leonarodne @ NEETSDKASU
##############################################
def gs(*_):  return input().strip()
def gi(*_):  return int(gs())
def gss(*_): return gs().split()
def gis(*_): return list(map(int, gss()))
def nmapf(n,f):  return list(map(f, range(n)))
def ngs(n):  return nmapf(n,gs)
def ngi(n):  return nmapf(n,gi)
def ngss(n): return nmapf(n,gss)
def ngis(n): return nmapf(n,gis)
##############################################

def solve():
    md = 10 ** 9
    n = gi()
    r = 1
    c = 0
    for i in range(1, n + 1):
        x = i
        while x % 5 == 0:
            c -= 1
            x /= 5
        while x % 2 == 0:
            c += 1
            x /= 2
        r *= x
        r %= md
    for i in range(c):
        r *= 2
        r %= md
    print(int(r))

solve()
