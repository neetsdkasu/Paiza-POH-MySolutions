// Try POH
// author: Leonardone @ NEETSDKASU

if let ns = readLine(), n = Int(ns) {
    var r = 1
    var c2 = 0
    var c5 = 0
    for i in 1...n {
        var x = i
        while x % 2 == 0 {
            x /= 2
            c2++
        }
        while x % 5 == 0 {
            x /= 5
            c5++
        }
        r *= x
        r %= 10_0000_0000
    }
    for _ in 0..<c2-c5 {
        r = (r * 2) % 10_0000_0000
    }
    print(r)
}
