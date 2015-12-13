// Try POH
// author: Leonardone @ NEETSDKASU

var readInts={readLine()!.utf8.split{$0==32}.map{Int(String($0))!}}

var xyzn=readInts(),a={(1...$0).map{_ in 0}+[1]},xs=a(xyzn[0]),ys=a(xyzn[1])
for _ in 1...xyzn[3]{
    var da=readInts()
    if da[0]==0{xs[da[1]]=1}else{ys[da[1]]=1}
}
func mn(xs:[Int],x:Int)->Int{
    var xc=0,xm=x
    for i in 1...x{
        xc++
        if xs[i]==1{xm=min(xm,xc);xc=0}
    }
    return xm
}
print(xyzn[2]*mn(xs,x:xyzn[0])*mn(ys,x:xyzn[1]))
