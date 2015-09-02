Public Class compiler
  Shared Function StrReverse(s As String) As String
    Dim c As Char, a() As Char = s.ToCharArray, i As Integer = 0, j As Integer = a.Length - 1
    Do While i < j
        c = a(i)
        a(i) = a(j)
        a(j) = c
        i += 1
        j -= 1
    Loop
    Return New String(a)
  End Function
  Shared Function Main as Integer
    Dim n As Integer = Int32.Parse(Console.ReadLine), w(n + 1) As String, res As String = "", c As String = "", x As String, y As String, k As Integer
    For i As Integer = 1 To n
        w(i) = Console.ReadLine
    Next i
    Array.Sort(w, 1, n)
    For i As Integer = 1 To n
        x = w(i)
        If x.Length = 0 Then
            Continue For
        End If
        y = StrReverse(x)
        k = Array.IndexOf(w, y, i + 1)
        If k = -1 Then
            If String.Compare(x, y) = 0 Then
                If c.Length = 0 Or String.Compare(x, c) < 0 Then
                    c = x
                End If
            End If
        Else
            res += x
            w(k) = ""
        End If
    Next i
    Console.WriteLine(res + c + StrReverse(res))
    Return 0
  End Function
End Class
