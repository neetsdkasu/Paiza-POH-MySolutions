'
' 結果 https://paiza.jp/poh/joshibato/kirishima/result/b41b8d05
'
Imports System
Public Class answer
    Shared Function Main%
        
        Dim n% = Int32.Parse(Console.ReadLine())
        Dim t_str$() = Console.ReadLine().Split(" ")
        Dim t%(), i%, m%, d%, r$, f%()
        Redim t(n)
        For i = 0 To n - 1
            t(i) = Int32.Parse(t_str(i))
        Next i
        m = Int32.Parse(Console.ReadLine())
        For i = 1 To m
            d = Int32.Parse(Console.ReadLine())
            r = "No"
            Redim f(n)
            Do
                If d < 1 Or d >= n Then Exit Do
                If d = n - 1 Then
                    r = "Yes"
                    Exit Do
                End If
                If t(d) = 0 Then Exit Do
                If f(d) <> 0 Then Exit Do
                f(d) = 1
                d += t(d)
            Loop
            Console.WriteLine(r)
        Next i
        
        Return 0
    End Function
End Class
