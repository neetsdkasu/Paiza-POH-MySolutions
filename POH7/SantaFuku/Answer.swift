// Try POH
// author: Leonardone @ NEETSDKASU

func readInt() -> Int {
    return Int(readLine() ?? "0") ?? 0
}

func readInts() -> [Int] {
    return (readLine() ?? "0").characters.split{$0==" "}.map{String($0)}.map{Int($0) ?? 0}
}

let b = readInts(), (x,y,z,n)=(b[0],b[1],b[2],b[3])

var para_soku = [0,x]
var para_zen = [0,y]

for _ in 1...n {
    let da = readInts()
    if da[0] == 0 {
        para_soku.append(da[1])
    } else {
        para_zen.append(da[1])
    }
}

para_soku.sortInPlace()
para_zen.sortInPlace()

func mn(a :[Int])->Int {
    var m = a[a.count - 1]
    for i in 1..<a.count {
        m = min(m, a[i] - a[i-1])
    }
    return m
}

print(z * mn(para_soku) * mn(para_zen))



