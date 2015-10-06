#
# 結果 https://paiza.jp/poh/joshibato/kirishima/result/6d4a87b3
#

process.stdin.resume()
process.stdin.setEncoding 'utf8'
process.stdin.on 'data', (chunk) ->
    lines = chunk.toString().trim().split '\n'
    n = parseInt lines[0]
    t = lines[1].split(' ').map (z) -> parseInt z
    m = parseInt lines[2]
    for d in lines[3..].map((z) -> parseInt z)
        f = (false for z in [1..n])
        r = 'No'
        loop
            break if d < 1 or d >= n
            if d is n - 1
                r = 'Yes'
                break
            break if t[d] == 0
            break if f[d]
            f[d] = true
            d += t[d]
        console.log r
