func r()->[UInt8]{return readLine()!.utf8.filter{$0 != 32}};var n = Int(readLine()!)!,q = [[UInt8]](),p = [[UInt8]](),m=n;for _ in 1...n{q.append(r())};m=Int(readLine()!)!;for _ in 1...m{p.append(r())};k:for y in 0...n-m{l:for x in 0...n-m{for i in 0..<m{for j in 0..<m{if q[y+i][x+j] != p[i][j]{continue l}}};print(y,x);break k}}
