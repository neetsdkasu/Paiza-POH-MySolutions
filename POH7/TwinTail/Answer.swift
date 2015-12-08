// Try POH
// author: Leonardone @ NEETSDKASU

if let s1 = readLine(), s2 = readLine() {
    func sp(s: String) -> [Double!] {
        return s.characters.split{$0==" "}.map{String($0)}.map{Double($0)}
    }
    func cp(a: [Double!]) -> Double {
        return a[0] / a[1]
    }
    if cp(sp(s1)) > cp(sp(s2)) {
        print(1)
    } else {
        print(2)
    }
}
