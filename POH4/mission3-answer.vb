Public Class compiler
  Shared Function Main As Integer
    Dim str() As String = Console.ReadLine().Split(" ")
    Dim t As Integer = Convert.ToInt32(str(0))
    Dim n As Integer = Convert.ToInt32(str(1))
    Dim maximum As Integer = 0
    Dim temp As Integer = 0
    Dim que As New System.Collections.Generic.Queue(Of Integer)
    For i As Integer = 1 To n
        Dim m As Integer = Convert.ToInt32(Console.ReadLine())
        que.Enqueue(m)
        If i > t Then
            temp += m - que.Dequeue()
        Else
            temp += m
        End If
        If temp > maximum Then
            maximum = temp
        End If
    Next i
    Console.WriteLine(maximum)
    Return 0
  End Function
End Class
