# coding: utf-8
# Try POH
# author: Leonardone @ NEETSDKASU
# ------------------------------------------------------
def gs():   return raw_input().strip()
def gi():   return int(gs())
def gl():   return long(gs())
def gss():  return gs().split()
def gis():  return map(int, gss())
def nmapf(n, f): return [f() for _ in xrange(n)]
def ngs(n): return nmapf(n, gs)
def ngi(n): return nmapf(n, gi)
def ngss(n): return nmapf(n, gss)
def ngis(n): return nmapf(n, gis)
def arr2d(h,w,v=0): return [[v] * w for _ in xrange(h)]
# ------------------------------------------------------

def solve():
    n = gi()
    r = 1
    c = 0
    md = 1000000000
    for x in xrange(1, n + 1):
        while x % 5 == 0:
            x //= 5
            c -= 1
        while x % 2 == 0:
            x //= 2
            c += 1
        r = (r * x) % md
    for _ in xrange(c):
        r = (r * 2) % md
    print(r)

solve()
