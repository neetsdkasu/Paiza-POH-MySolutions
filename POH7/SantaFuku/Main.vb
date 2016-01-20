' Try POH
' author: Leonardone @ NEETSDKASU
Imports System
Imports Con = System.Console
Imports System.Collections
Imports System.Collections.Generic

Module Main
    
    Sub Main()
        Dim x%, y%, z%, n%, i%, da%()
        Ib(Gis(), x, y, z, n)
        Dim xs As New List(Of Integer)(Arr(0, x))
        Dim ys As New List(Of Integer)(Arr(0, y))
        For Each da In NGis(n)
            If da(0) = 0 Then
                xs.Add(da(1))
            Else
                ys.Add(da(1))
            End If
        Next da
        xs.Sort()
        ys.Sort()
        For i = 1 To xs.Count - 1
            x = Math.Min(x, xs(i) - xs(i - 1))
        Next i
        For i = 1 To ys.Count - 1
            y = Math.Min(y, ys(i) - ys(i - 1))
        Next i
        Con.WriteLine(x * y * z)
    End Sub
    
    ' ----------------------------------------------------------------------------------
    Delegate Function MyFunc(Of T)() As T ' System.Func1(Of T)が何故か使えない
    Function Gs$(): Gs = Console.ReadLine(): End Function
    Function Gi%(): Gi = Int32.Parse(Gs()):  End Function
    Function Gl&(): Gl = Int64.Parse(Gs()):  End Function
    Function Gss() As String(): Gss = Gs().Split(" ".ToCharArray()): End Function
    Function Gis() As Integer(): Dim i%, a%(): Dim s$() = Gss(): ReDim a(s.Length - 1): For i = 0 To s.Length - 1: a(i) = Int32.Parse(s(i)): Next i: Gis = a: End Function
    Function NGt(Of T)(n%, f As MyFunc(Of T)) As T(): Dim a() As T, i%: ReDim a(n - 1): For i = 0 To n - 1: a(i) = f.Invoke(): Next i: NGt = a: End Function
    Function NGs(n%) As String(): NGs = NGt(Of String)(n, AddressOf Gs): End Function
    Function NGi(n%) As Integer(): NGi = NGt(Of Integer)(n, AddressOf Gi): End Function
    Function NGss(n%) As String()(): NGss = NGt(Of String())(n, AddressOf Gss): End Function
    Function NGis(n%) As Integer()(): NGis = NGt(Of Integer())(n, AddressOf Gis): End Function
    Function SubArr(a() As Integer, s%) As Integer(): Dim r() As Integer: If s < a.Length Then: ReDim r(a.Length - s - 1): Array.Copy(a, s, r, 0, r.Length): End If: SubArr = r: End Function
    Function SubArr(a() As Integer, s%, l%) As Integer(): Dim r() As Integer: If l > 0 Then: ReDim r(l - 1): Array.Copy(a, s, r, 0, l): End If: SubArr = r: End Function
    Function Ib(a() As Integer, ByRef v1%) As Integer(): v1 = a(0): Ib = SubArr(a, 1): End Function
    Function Ib(a() As Integer, ByRef v1%, ByRef v2%) As Integer(): v1 = a(0): v2 = a(1): Ib = SubArr(a, 2): End Function
    Function Ib(a() As Integer, ByRef v1%, ByRef v2%, ByRef v3%) As Integer(): v1 = a(0): v2 = a(1): v3 = a(2): Ib = SubArr(a, 3): End Function
    Function Ib(a() As Integer, ByRef v1%, ByRef v2%, ByRef v3%, ByRef v4%) As Integer(): v1 = a(0): v2 = a(1): v3 = a(2): v4 = a(3): Ib = SubArr(a, 4): End Function
    Function Arr(ByVal ParamArray a() As Integer) As Integer(): Arr = a: End Function
    ' ----------------------------------------------------------------------------------
End Module
