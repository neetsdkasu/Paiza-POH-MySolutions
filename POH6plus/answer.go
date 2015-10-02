package main

import (
    "fmt"
    "sort"
)

// How to Write Go Code の Reverse
// https://golang.org/doc/code.html#Library
func Reverse(s string) string {
    r := []rune(s)
    for i,j :=0,len(r)-1; i<=j; i,j=i+1,j-1 {
        r[i],r[j]=r[j],r[i]
    }
    return string(r)
}

func main(){
    
    var n int
    fmt.Scanf("%d", &n)
    // fmt.Printf("%d", n)
    
    // var w [1000]string // 静的？
    // var w []string = make([]string, n) // 動的？
    // w := make([]string, n) // 動的？
    w := make(sort.StringSlice, n) // Sortメソッド等を持ってる拡張された[]string
    for i := 0; i < n; i++ {
        fmt.Scanf("%s", &w[i])
    }
    
    // sort.Strings(w) // wに[]stringを使う場合
    w.Sort() // StringSliceはSortメソッドを持っている
    
    lp := ""
    rp := ""
    cp := ""
    
    for i := 0; i < n; i++ {
        x := w[i]
        if x == "" {
            continue
        }
        r := Reverse(x)
        j := i + 1
        for ; j < n; j++ {
            if r == w[j] {
                lp += x
                rp = r + rp
                w[j] = ""
                break
            }
        }
        if j == n && x == r && (cp == "" || x < cp) {
            cp = x
        }
    }
    
    fmt.Println(lp + cp + rp)
    
}
