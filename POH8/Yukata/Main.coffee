# Try POH
# author: Leonardone @ NEETSDKASU
# ===================================================

solve = (mr) ->
    n = mr.gi()
    x = 0
    b = 0
    c = 0
    while n > 0
        n--
        [t, s] = mr.gss()
        h = parseInt t
        if x > 0
            df = h - b
            tx = Math.max x - df, 0
            c += x - tx
            x = tx
        b = h
        switch s
            when 'out' then x += 3
            when 'in'  then x += 5
    if x > 0
        df = 24 - b
        tx = Math.max x - df, 0
        c += x - tx
        x = tx
    console.log c + 24

# ===================================================
(->
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
