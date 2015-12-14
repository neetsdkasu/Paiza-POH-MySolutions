// Try POH
// author: Leonardone @ NEETSDKASU

var n=Int(readLine()!)!,m=Int(readLine()!)!,s=""

for i in 0..<m{
    s+=i%(n*2)<n ?"R":"W"
}
print(s)
