package main

import("fmt";"sort")

func Reverse(s string)string{
    r:=[]rune(s)
    for i,j:=0,len(r)-1;i<=j;i,j=i+1,j-1 {r[i],r[j]=r[j],r[i]}
    return string(r)
}

func main(){
    n:=0
    fmt.Scanf("%d",&n)
    w:=make([]string,n)
    for i:=0;i<n;i++{fmt.Scanf("%s",&w[i])}
    sort.Strings(w)
    lp,rp,cp:="","",""
    for i:=0;i<n;i++{
        x:=w[i]
        if x==""{continue}
        r,j:=Reverse(x),i+1
        for;j<n;j++{if r==w[j]{lp,rp,w[j]=lp+x,r+rp,"";break}}
        if j==n&&x==r&&(cp==""||x<cp){cp=x}
    }
    fmt.Print(lp+cp+rp)
}
