var r = {readLine()!.utf8.filter{$0>32}},n = Int(readLine()!)!,q = r(),m=n;for _ in 2...n{q+=r()};m=Int(readLine()!)!;for _ in 1...m{q+=r()};for y in 0...n-m{l:for x in 0...n-m{for i in 0..<m{for j in 0..<m{if 0<q[(y+i)*n+x+j]^q[n*n+i*m+j]{continue l}}};print(y,x)}}
