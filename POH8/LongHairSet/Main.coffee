# Try POH
# author: Leonardone @ NEETSDKASU
# ===================================================

solve = (mr) ->
    n = mr.gi()
    if n % 7 == 0
        console.log 'lucky'
    else
        console.log 'unlucky'

# ===================================================
process.stdin.resume()
process.stdin.setEncoding 'utf8'
process.stdin.on 'data', (chunk) ->
    lines = chunk.toString().split '\n'
    cur = 0
    gs = -> lines[cur++]
    gi = -> parseInt gs()
    gss = -> gs().split ' '
    gis = -> gss().map (x) -> parseInt x
    ngt = (n, f) -> f() for _ in [1..n]
    ngs = (n) -> ngt n, gs
    ngi = (n) -> ngt n, gi
    ngss = (n) -> ngt n, gss
    ngis = (n) -> ngt n, gis
    solve "gs": gs, "gi": gi, "gss": gss, "gis": gis, "ngs": ngs, "ngi": ngi, "ngss": ngss, "ngis": ngis 
# ===================================================
