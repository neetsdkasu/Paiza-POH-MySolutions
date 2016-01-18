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
    p = ngis(n)
    m = gi()
    q = ngis(m)
    nm = xrange(n - m + 1)
    for i in nm:
        for j in nm:
            if q == map(lambda (x): x[j:j+m], p[i:i+m]):
                print i, j
    
solve()
