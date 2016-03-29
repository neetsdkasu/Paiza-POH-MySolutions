// Try POH
// author: Leonardone @ NEETSDKASU
// =============================================================
func ti(s :String) -> Int { if let v : Int = Int(s) { return v } else { return 0 } }
func gs() -> String { if let s : String = readLine() { return s } else { return "" } }
func gi() -> Int { return ti(gs()) }
func gss() -> [String] { return gs().characters.split{ $0 == " " }.map{ String($0) } }
func gis() -> [Int] { return gss().map(ti) } // [Type] は Array<Type> の糖衣構文的な？
func ngt<T>(n :Int, f :() -> T) -> [T] { var a : [T] = [T](); for _ in 1...n { a.append(f()) }; return a }
func ngs(n :Int) -> [String] { return ngt(n, f: gs) }
func ngi(n :Int) -> [Int] { return ngt(n, f: gi) }
func ngss(n :Int) -> [[String]] { return ngt(n, f: gss) }
func ngis(n :Int) -> [[Int]] { return ngt(n, f: gis) }
func Bv2(a :[Int]) -> (Int, Int, [Int]) { return (a[0], a[1], [Int](a[2..<a.count])) }
func Bv3(a :[Int]) -> (Int, Int, Int, [Int]) { return (a[0], a[1], a[2], [Int](a[3..<a.count])) }
func Bv4(a :[Int]) -> (Int, Int, Int, Int, [Int]) { return (a[0], a[1], a[2], a[3], [Int](a[4..<a.count])) }
func Bv5(a :[Int]) -> (Int, Int, Int, Int, Int, [Int]) { return (a[0], a[1], a[2], a[3], a[4], [Int](a[5..<a.count])) }
// =============================================================


func solve() {
    let s = gs()
    
    var c = 0
    var a = 0
    var t = 0
    
    for i in s.startIndex ..< s.endIndex {
        switch s[i] {
        case "c":
            c += 1
        case "a":
            a += 1
        case "t":
            t += 1
        default:
            break
        }
    }
    
    let mn = min(c, a, t)
    let mx = max(c, a, t) 
    
    print(mn)
    print(mx - c)
    print(mx - a)
    print(mx - t)
    
}


solve()

