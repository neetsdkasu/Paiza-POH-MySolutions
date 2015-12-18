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
    minx, miny, *_ = x, y, z, n = gis()
    
    da = ngis(n)
    
    for i in range(n):
        d, a = da[i]
        t = min([a] + list(map(lambda v: abs(v[1]-a), filter(lambda v: v[0]==d, da[i+1:]))))
        if d == 0:
            minx = min(minx, t, x - a)
        else:
            miny = min(miny, t, y - a)
            
    print(minx * miny * z)

solve()
