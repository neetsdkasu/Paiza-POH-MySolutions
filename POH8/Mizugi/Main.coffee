# Try POH
# author: Leonardone @ NEETSDKASU
# ===================================================

solve = (mr) ->
    [n, m] = mr.gis()
    s = mr.gs()
    g = mr.gs()
    x = (0 for _ in [0 .. 27])
    a = 'a'.charCodeAt 0
    for c in s
        x[c.charCodeAt(0) - a]++ 
    for c in g
        x[c.charCodeAt(0) - a]--
    needs = 0
    needs -= i for i in x when i < 0
    console.log needs
    
# ===================================================
(() ->
    buf = ''
    process.stdin.resume()
    process.stdin.setEncoding 'utf8'
    process.stdin.on 'data', (chunk) -> buf += chunk.toString()
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
