# Try POH
# author: Leonardone @ NEETSDKASU

process.stdin.resume()
process.stdin.setEncoding 'utf8'
process.stdin.on 'data', (data) ->
    n = parseInt data.toString()
    r = 1
    c = 0
    md = 1000000000
    while n > 1
        x = n--
        while x % 5 == 0
            x /= 5
            c--
        while x % 2 == 0
            x /= 2
            c++
        r = (r * x) % md
    while c-- > 0
        r = (r * 2) % md
    console.log r
