// Try POH
// author: Leonardone @ NEETSDKASU

var ri={Int(readLine()!)!}
var ris={readLine()!.utf8.split{$0==32}.map{Int(String($0))!}.sort()}
var n=ri(),m1=ri(),x=ris(),m2=ri(),y=ris(),s=""
for i in y{
    if !x.contains(i){
        s+=(s>"" ?" ":"")+String(i)
    }
}
print(s>"" ?s:"None")
