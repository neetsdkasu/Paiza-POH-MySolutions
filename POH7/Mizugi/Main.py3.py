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

def solve(n):
    md = 10 ** 9
    r = 1
    q = 1
    j = 0
    c = 0
    for x in range(1, n + 1):
        q *= x
        j += 1
        if j < 5:
            continue
        while q % 5 == 0:
            c -= 1
            q //= 5
        while q % 2 == 0:
            c += 1
            q >>= 1
        r = (r * q) % md
        q = 1
        j = 0
    while q % 5 == 0:
        c -= 1
        q //= 5
    while q % 2 == 0:
        c += 1
        q >>= 1
    r = (r * q) % md
    for _ in range(c // 30):
        r = (r << 30) % md
    for _ in range(c % 30):
        r = (r << 1) % md
    return r

print(solve(gi()))
