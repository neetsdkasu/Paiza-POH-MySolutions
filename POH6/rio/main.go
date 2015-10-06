//
// 結果 https://paiza.jp/poh/joshibato/rio/result/0edbfb23
//
package main
import "fmt"

func main() {
    
    var n int
    fmt.Scanf("%d", &n)
    
    var w float64 = 0.0
    var c float64 = 0.0
    
    for i := 0; i < n; i++ {
        var t int
        var s float64
        fmt.Scanf("%d %f", &t, &s)
        switch t {
        case 1:
            w += s
        case 2:
            c += s
        case 3:
            wc := w + c
            w = (w * wc - s * w) / wc
            c = (c * wc - s * c) / wc
        }
        
    }

    ans := 100.0 * c / (w + c)
    fmt.Printf("%d\n", int(ans))
}
