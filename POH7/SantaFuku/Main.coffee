# Try POH
# author: Leonardone @ NEETSDKASU

process.stdin.resume()
process.stdin.setEncoding 'utf8'
process.stdin.on 'data', (data) ->
    lines = data.toString().trim().split('\n').map (s) -> s.split(' ').map (x) -> parseInt x
    [x, y, z, n] = lines.shift()
    xs = [0, x]
    ys = [0, y]
    while n-- > 0
        [d, a] = lines.shift()
        if d == 0
            xs.push a
        else
            ys.push a
    xs.sort (a, b) -> a - b
    ys.sort (a, b) -> a - b
    for i in [1...xs.length]
        x = Math.min x, xs[i] - xs[i - 1]
    y = Math.min y, ys[i] - ys[i - 1] for i in [1...ys.length] 
    ans = x * y * z
    console.log ans
