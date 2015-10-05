#
# 結果 https://paiza.jp/poh/joshibato/tsubame/result/82316079
#

process.stdin.resume()
process.stdin.setEncoding 'utf8'
process.stdin.on 'data', (chunk) ->
    n_str = chunk.toString().trim()
    n = parseInt n_str
    n1 = parseInt n_str.substring 1, 2
    n10 = parseInt n_str.substr 0, 1
    r = n + n1 + n10
    console.log r
