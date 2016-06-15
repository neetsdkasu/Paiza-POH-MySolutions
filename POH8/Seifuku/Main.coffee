# Try POH
# author: Leonardone @ NEETSDKASU
# ===================================================

solve = (mr) ->
    c = mr.gss().map (x) -> switch x
        when 'J' then 11
        when 'Q' then 12
        when 'K' then 13
        when 'A' then 14
        when '2' then 15
        else parseInt x
    
    r = (0 for _ in [0...52])
    k = 1
    j = -1
    t = 0
    while k < 53
        for i in [0...52]
            if i is j
                t = 0
                j = -1
            continue if r[i] > 0
            if t < c[i]
                r[i] = k
                t = c[i]
                j = i
                k++
    
    console.log r.join '\n'
        
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
