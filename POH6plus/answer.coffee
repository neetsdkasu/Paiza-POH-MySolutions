
strrev = (s) -> s.split("").reverse().join("")

process.stdin.resume()
process.stdin.setEncoding "utf8"
process.stdin.on 'data', (chunk) ->
    w = chunk.toString().trim().split("\n")
    n = parseInt w[0]
    w.sort()
    s = ""
    c = ""
    for idx1 in [1..n]
        x = w[idx1]
        continue if x is ""
        r = strrev x
        idx2 = w.indexOf r, idx1 + 1
        if idx2 > idx1
            s += x
            w[idx2] = ""
        else if x is r and (c is "" or c > r)
            c = r
    console.log s + c + strrev(s)
