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
    n = gi()
    q = ngis(n)
    m = gi()
    p = ngis(m)
    for i in range(n - m + 1):
        for j in range(n - m + 1):
            f = True
            for k in range(m):
                f &= q[i + k][j:j+m] == p[k]
            if f:
                print(i,j)

solve()
