// Try POH
// author: Leonardone @ NEETSDKASU
using System;
using System.Collections.Generic;
using System.Linq;

public class Solver
{
    public static void Main()
    {
       int x, y, z, n; Ib(Gis(), out x, out y, out z, out n);
       var xs = Arr(0, x).ToList();
       var ys = Arr(0, y).ToList();
       foreach (var da in NGis(n))
       {
           (da[0] == 0 ? xs : ys).Add(da[1]);
       }
       xs.Sort();
       ys.Sort();
       x = xs.Zip(xs.Skip(1), (a, b) => b - a).Min();
       y = ys.Zip(ys.Skip(1), (a, b) => b - a).Min();
       Console.WriteLine(x * y * z);
    }
    
    ///////////////////////////////////////////////////////////////////
    static string   Gs()  { return Console.ReadLine(); }
    static int      Gi()  { return int.Parse(Gs()); }
    static long     Gl()  { return long.Parse(Gs()); }
    static string[] Gss() { return Gs().Split(" ".ToCharArray()); }
    static int[]    Gis() { return Gss().Select( int.Parse ).ToArray(); }
    static T[]      NGt<T>(int n, Func<T> f) { return Enumerable.Range(0, n).Select( _ => f() ).ToArray(); }
    static string[] NGs(int n) { return NGt(n, Gs); }
    static int[]    NGi(int n) { return NGt(n, Gi); }
    static string[][] NGss(int n) { return NGt(n, Gss); }
    static int[][]    NGis(int n) { return NGt(n, Gis); }
    static void Ib(int[] a, out int v1, out int v2) { v1 = a[0]; v2 = a[1]; }
    static void Ib(int[] a, out int v1, out int v2, out int v3) { v1 = a[0]; v2 = a[1]; v3 = a[2]; }
    static void Ib(int[] a, out int v1, out int v2, out int v3, out int v4) { v1 = a[0]; v2 = a[1]; v3 = a[2]; v4 = a[3]; }
    static T[] Arr<T>(params T[] p) { return p; }
    ///////////////////////////////////////////////////////////////////
}
