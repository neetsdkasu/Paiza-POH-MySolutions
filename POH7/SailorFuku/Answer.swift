// Try POH
// author: Leonardone @ NEETSDKASU

if let ns = readLine(), n = Int(ns) {
    var s = ""
    for i in 0..<n {
        if i > 0 {
            s += "_"
        }
        if let w = readLine() {
            s += w
        }
    }
    print(s)
}
