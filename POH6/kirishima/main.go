//
// 結果 https://paiza.jp/poh/joshibato/kirishima/result/5cc75430
//
package main
import "fmt"

func main() {
    
    var n int
    var m int
    
    fmt.Scanf("%d", &n)
    
    var t = make([]int, n)
    
    for i := 0; i < n; i++ {
        var t_val int
        fmt.Scanf("%d", &t_val)
        t[i] = t_val
    }
    
    fmt.Scanf("%d", &m)
    
    for i := 0; i < m; i++ {
        var d int
        var f = make([]bool, n)
        var r = "No"
        fmt.Scanf("%d", &d)
        for {
            if d < 1 || d >= n {
                break
            }
            if d == n - 1 {
                r = "Yes"
                break
            }
            if t[d] == 0 {
                break
            }
            if f[d] {
                break
            }
            f[d] = true
            d += t[d]
        }
        fmt.Println(r)
    }
    
}
