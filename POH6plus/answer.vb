Public Class compiler
  Shared Function StrReverse(s As String) As String
    Dim a() As Char = s.ToCharArray
    Dim i As Integer = 0
    Dim j As Integer = a.Length - 1
    Do While i < j
        Dim c As Char = a(i)
        a(i) = a(j)
        a(j) = c
        i += 1
        j -= 1
    Loop
    Return New String(a)
  End Function
  Shared Function Main as Integer
    Dim n As Integer = Int32.Parse(Console.ReadLine)
    Dim w(n) As String
    Dim res As String = ""
    For i As Integer = 1 To n
        w(i) = Console.ReadLine
    Next i
    Array.Sort(w, 1, n)
    Dim c As String = ""
    For i As Integer = 1 To n
        Dim x As String = w(i)
        If x.Length = 0 Then
            Continue For
        End If
        Dim y As String = StrReverse(x)
        Dim k As Integer = Array.IndexOf(w, y, i + 1)
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
