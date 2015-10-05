/*
 * 結果 https://paiza.jp/poh/joshibato/tsubame/result/96173864
 */
package main
import (
    "fmt"
    "strconv"
)

func main(){
    
    var n_str string
    
    fmt.Scanf("%s", &n_str)
    
    if n, err := strconv.ParseInt(n_str, 10, 32); err == nil {
        
        if n1, err := strconv.Atoi(n_str[1:2]); err == nil {
            
            if n10, err := strconv.ParseInt(n_str[0:1], 10, 0); err == nil {
                
                // Atoi(x) は ParseInt(x,10,0) と同じ処理をするが1つ目の戻り値の型が int (intはint32と同じ)
                // ParseInt は第2引数は基数、第3引数はビット数 ビット数は0を指定でintと同じビット数になる
                // ただしParseIntの1つ目の戻り値の型は int64、Atoiと混ぜて使うのは避けたほうがよさげ
                
                r := n + int64(n1) + n10  // キャストしないと計算できない
            
                fmt.Println(r)
            }
        }

    }
    
}
