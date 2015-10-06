#
# 結果 https://paiza.jp/poh/joshibato/rio/result/7698348f
#

process.stdin.resume()
process.stdin.setEncoding 'utf8'
process.stdin.on 'data', (chunk) ->
    lines = chunk.toString().trim().split '\n'
    n = parseInt lines[0]
    w = 0.0
    c = 0.0
    for i in [1..n]
        [t, s] = lines[i].split(' ').map (z) -> parseFloat z
        switch t
            when 1 then w += s
            when 2 then c += s
            else
                wc = w + c
                w = (w * wc - s * w) / wc
                c = (c * wc - s * c) / wc
    ans = 100.0 * c / (w + c)
    console.log parseInt ans

