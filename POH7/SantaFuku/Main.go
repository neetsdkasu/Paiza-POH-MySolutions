/* Try POH
 * author: Leonardone @ NEETSDKASU
 */
package main

import (
    "bufio"; "os"; "strconv"; "strings"
    "fmt"
    "sort"
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

func I2(a []int) (int, int) { return a[0], a[1] }
func I3(a []int) (int, int, int) { return a[0], a[1], a[2] }
func I4(a []int) (int, int, int, int) { return a[0], a[1], a[2], a[3] }
func I5(a []int) (int, int, int, int, int) { return a[0], a[1], a[2], a[3], a[4] }

func Min(v int, vs ...int) (r int) { r = v; for _, x := range vs { if x < r { r = x } }; return }
func Max(v int, vs ...int) (r int) { r = v; for _, x := range vs { if x > r { r = x } }; return }
func MinMax(v int, vs ...int) (mn, mx int) { mn, mx = v, v; for _, x := range vs { if x < mn { mn = x } else if x > mx { mx = x } }; return }

func main() { solve(NewMyReader()) }

func solve(mr *MyReader) {
    
    x, y, z, n := I4(mr.Gis())
    
    xs := []int{0, x}
    ys := []int{0, y}
    
    for _, da := range mr.NGis(n) {
        d, a := I2(da)
        if d == 0 {
            xs = append(xs, a)
        } else {
            ys = append(ys, a)
        }
    }
    
    sort.Ints(xs)
    sort.Ints(ys)
    
    min := func(vs []int, r int) int {
       for i := 1; i < len(vs); i++ { r = Min(r, vs[i] - vs[i-1]) }; return r 
    }
    
    xmin := min(xs, x)
    ymin := min(ys, y)
    
    ans := xmin * ymin * z
    
    fmt.Println(ans)
}
