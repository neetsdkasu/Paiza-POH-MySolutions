'
' 結果 https://paiza.jp/poh/joshibato/rio/result/9e4a73b2
'
Imports System

Public Class answer
    Shared Function Main%()
        
        Dim n% = Int32.Parse(Console.ReadLine())
        Dim i%, w#, c#, wc#, ans%
        
        For i = 1 To n
            Dim tas$() = Console.ReadLine().Split(" ")
            Dim t% = Int32.Parse(tas(0))
            Dim s# = Double.Parse(tas(1))
            
            Select Case t
            Case 1
                w += s
            Case 2
                c += s
            Case Else
                wc = w + c
                w = (w * wc - s * w) / wc
                c = (c * wc - s * c) / wc
            End Select
        Next i
        
        ans = Math.Floor(100.0 * c / (w + c))
        
        Console.WriteLine(ans)
        
        Return 0
    End Function
End Class
