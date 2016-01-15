/* Try POH
 * author: Leonardone @ NEETSDKASU
 */
package main

import (
    "bufio"; "os"; "strconv"; "strings"
    "fmt"
)

// 別に fmt.Scanf() を使ってもいいんだけどね、無駄に定義しまくり
func Ti(s string) (v int) { v, _ = strconv.Atoi(s); return }
func Tl(s string) (v int64) { v, _ = strconv.ParseInt(s, 10, 64); return }
type MyReader struct { scn *bufio.Scanner }
func NewMyReader()  (mr *MyReader) { mr = new(MyReader); mr.scn = bufio.NewScanner(os.Stdin); return }
func (mr *MyReader) Gs()  string   { mr.scn.Scan(); return mr.scn.Text() }
func (mr *MyReader) Gi()  int      { return Ti(mr.Gs()) }
func (mr *MyReader) Gl()  int64    { return Tl(mr.Gs()) }
func (mr *MyReader) Gss() []string { return strings.Split(mr.Gs(), " ") }
func (mr *MyReader) Gis()       (vs  []int)      { for _, v := range mr.Gss() { vs = append(vs, Ti(v)) };  return }
func (mr *MyReader) NGs(n int)  (ss  []string)   { for i := 0; i < n; i++ { ss  = append(ss,  mr.Gs()) };  return }
func (mr *MyReader) NGi(n int)  (vs  []int)      { for i := 0; i < n; i++ { vs  = append(vs,  mr.Gi()) };  return }
func (mr *MyReader) NGss(n int) (sss [][]string) { for i := 0; i < n; i++ { sss = append(sss, mr.Gss()) }; return }
func (mr *MyReader) NGis(n int) (vss [][]int)    { for i := 0; i < n; i++ { vss = append(vss, mr.Gis()) }; return }

func Bind(vs []int, v ...*int) { for i := range v { *v[i] = vs[i] } }
func I2(a []int) (int, int) { return a[0], a[1] }
func I3(a []int) (int, int, int) { return a[0], a[1], a[2] }
func I4(a []int) (int, int, int, int) { return a[0], a[1], a[2], a[3] }
func I5(a []int) (int, int, int, int, int) { return a[0], a[1], a[2], a[3], a[4] }

func Min(v int, vs ...int) (r int) { r = v; for _, x := range vs { if x < r { r = x } }; return }
func Max(v int, vs ...int) (r int) { r = v; for _, x := range vs { if x > r { r = x } }; return }
func MinMax(v int, vs ...int) (mn, mx int) { mn, mx = v, v; for _, x := range vs { if x < mn { mn = x } else if x > mx { mx = x } }; return }

func main() { solve(NewMyReader()) }

func solve(mr *MyReader) {
    
    n := mr.Gi()
    p := mr.NGis(n)
    m := mr.Gi()
    q := mr.NGis(m)
    
    for i := 0; i <= n - m; i++ {
        for j := 0; j <= n - m; j++ {
            match := true
            for y := 0; y < m; y++ {
                for x := 0; x < m; x++ {
                    match = match && p[i+y][j+x] == q[y][x]
                }
            }
            if match {
                fmt.Println(i, j)
            }
        }
    }    
}
