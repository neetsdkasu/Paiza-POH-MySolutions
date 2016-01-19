' Try POH
' author: Leonardone @ NEETSDKASU
Imports System

Public Class Main
    Public Shared Sub Main()
        Dim n& = Gl(), r& = 1, c% = 0, i&
        For i = 1 To n
            Dim x& = i
            Do While x Mod 5 = 0
                x \= 5
                c -= 1
            Loop
            While x Mod 2 = 0
                x \= 2
                c += 1
            End While
            r = (r * x) Mod 1000000000
        Next i
        For i = 1 To c
            r = (r * 2) Mod 1000000000
        Next i
        Console.WriteLine(r)
    End Sub
    
    Shared Function Gs$(): Gs = Console.ReadLine(): End Function
    Shared Function Gi%(): Gi = Int32.Parse(Gs()):  End Function
    Shared Function Gl&(): Gl = Int64.Parse(Gs()):  End Function
End Class
