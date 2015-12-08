// Try POH
// author: Leonardone @ NEETSDKASU

func readInt() -> Int {
    return Int(readLine() ?? "0") ?? 0
}

func readInts() -> [Int] {
    return (readLine() ?? "0").characters.split{$0==" "}.map{String($0)}.map{Int($0) ?? 0}
}

let n = readInt()
var q = [[Int]]()

for _ in 1...n {
    q.append(readInts())
}

let m = readInt();
var p = [[Int]]()

for _ in 1...m {
    p.append(readInts())
}

let r2 = 0..<m

func chk(offx :Int, offy :Int) -> Bool {
    for y in r2 {
        for x in r2 {
            if q[offy + y][offx + x] != p[y][x] {
                return false
            }
        }
    }
    return true
}

let r1 = 0...(n - m)

func solve() -> (Int, Int) {
    for y in r1 {
        for x in r1 {
            if chk(x, offy: y) {
                return (y, x)
            }
        }
    }
    return (0, 0)
}

let (i, j) = solve()

print(i, j)

