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
    x, y, z, n = gis()
    xs, ys = [0, x], [0, y]
    for d, a in ngis(n):
        if d == 0:
            xs.append(a)
        else:
            ys.append(a)
    xs.sort()
    ys = sorted(ys)
    xmin = min(map(lambda (a,b): b - a, zip(xs, xs[1:len(xs)])))
    ymin = min(map(lambda (a,b): b - a, zip(ys, ys[1:len(ys)])))
    ans = xmin * ymin * z
    print ans

solve()
