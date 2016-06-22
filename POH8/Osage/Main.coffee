# Try POH
# author: Leonardone @ NEETSDKASU
# ===================================================

solve = (mr) ->
    n = mr.gi() * 60
    m = mr.gi()
    t = mr.ngi m
    c = 0
    for t_i in t
        n -= t_i
        c++ if n >= 0
    console.log (if c == m then 'OK' else c.toString())

# ===================================================
(() ->
    buf = ''
    process.stdin.setEncoding 'utf8'
    process.stdin.on 'data', (data) -> buf += data.toString()
    process.stdin.on 'end', () ->
        lines = buf.split '\n'
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
    )()
# ===================================================
