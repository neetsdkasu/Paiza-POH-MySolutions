# Try POH
# author: Leonardone @ NEETSDKASU

process.stdin.resume()
process.stdin.setEncoding 'utf8'
process.stdin.on 'data', (data) ->
    lines = data.toString().trim().split('\n').map (s) -> s.split(' ').map (x) -> parseInt x
    [n] = lines.shift()
    q = lines[0...n]
    p = lines[n..]
    [m] = p.shift()
    for i in [0..n-m]
        for j in [0..n-m]
            flag = true
            for y in [0...m]
                for x in [0...m]
                    flag &= q[i+y][j+x] == p[y][x]
            if flag
                console.log i + ' ' + j
