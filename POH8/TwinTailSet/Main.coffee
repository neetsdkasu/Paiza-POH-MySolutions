# Try POH
# author: Leonardone @ NEETSDKASU
# ===================================================

solve = (mr) ->
    s = mr.gi()
    t = mr.gi()
    r = ''
    for i in [1..s]
        r += if i is t then '+' else '-'
    console.log r

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
