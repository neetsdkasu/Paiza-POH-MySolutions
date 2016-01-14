/* Try POH
 * author: Leonardone @ NEETSDKASU
 */
package main

import (
    "fmt"
    "bufio"
    "os"
    "strconv"
    "strings"
)

func ti(s string) (v int) { v, _ = strconv.Atoi(s); return }
func tl(s string) (v int64) { v, _ = strconv.ParseInt(s, 10, 64); return }
type MyReader struct { scn *bufio.Scanner }
func NewMyReader()  (mr *MyReader) { mr = new(MyReader); mr.scn = bufio.NewScanner(os.Stdin); return }
func (mr *MyReader) Gs()  string   { mr.scn.Scan(); return mr.scn.Text() }
func (mr *MyReader) Gi()  int      { return ti(mr.Gs()) }
func (mr *MyReader) Gl()  int64    { return tl(mr.Gs()) }
func (mr *MyReader) Gss() []string { return strings.Split(mr.Gs(), " ") }
func (mr *MyReader) Gis()       (vs  []int)      { for _, v := range mr.Gss() { vs = append(vs, ti(v)) };  return }
func (mr *MyReader) NGs(n int)  (ss  []string)   { for i := 0; i < n; i++ { ss  = append(ss,  mr.Gs()) };  return }
func (mr *MyReader) NGi(n int)  (vs  []int)      { for i := 0; i < n; i++ { vs  = append(vs,  mr.Gi()) };  return }
func (mr *MyReader) NGss(n int) (sss [][]string) { for i := 0; i < n; i++ { sss = append(sss, mr.Gss()) }; return }
func (mr *MyReader) NGis(n int) (vss [][]int)    { for i := 0; i < n; i++ { vss = append(vss, mr.Gis()) }; return }

func main() { solve(NewMyReader()) }

func solve(mr *MyReader) {
    
    var r, modval int64
    
    modval = 1000000000
    r = 1
    c := 0
    n := mr.Gl()
    
    for n > 1 {
        x := n
        n--
        for x % 5 == 0 {
            x /= 5
            c--
        }
        for x % 2 == 0 {
            x /= 2
            c++
        }
        r = (r * x) % modval
    }
    
    for c > 0 {
        r = (r * 2) % modval
        c--
    }
    
    fmt.Println(r)
}
