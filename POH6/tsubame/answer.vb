'
' 結果 https://paiza.jp/poh/joshibato/tsubame/result/7247a5fd
'
Imports System

Public Class answer
  Shared Function Main As Integer
    Dim n%, n1%, n10%, r%
    
    n = Int32.Parse(Console.ReadLine())  ' VBならCInt使いたいよねー
    
    n1 = n Mod 10
    n10 = (n - n1) \ 10
    
    r = n + n1 + n10
    
    Call Console.WriteLine(r) ' 特に意味なくCall
    
    Return 0
  End Function
End Class
