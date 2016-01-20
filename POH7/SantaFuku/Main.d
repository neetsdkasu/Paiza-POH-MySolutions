// Try POH
// author: Leonardone @ NEETSDKASU
import std.stdio, std.conv, std.array, std.string, std.range, std.algorithm;

void main()
{
    int x, y, z, n; Bv(gis(), x, y, z, n);
    auto xs = appender([0, x]);
    auto ys = appender([0, y]);
    foreach (da; ngis(n))
    {
        (da[0] == 0 ? xs : ys).put(da[1]);
    }
    auto f(int[] vs) { vs.sort(); return zip(vs, vs[1..$]).map!( t => t[1] - t[0] ).minCount()[0]; }
    x = f(xs.data);
    y = f(ys.data);
    writeln(x * y * z);
}

// --------------------------------------------------------------------------
auto gs()  { return chomp(readln()); }
auto gi()  { return to!int(gs()); }
auto gl()  { return to!long(gs()); }
auto gss() { return split(gs); }
auto gis() { return to!(int[])(gss()); }
auto ngt(T)(int n, T function() f) { return array(map!( _ => f() )(iota(0, n))); } // mapは遅延評価
auto ngs(int n) { return ngt(n, &gs); }
auto ngi(int n) { return ngt(n, &gi); }
auto ngss(int n) { return ngt(n, &gss); }
auto ngis(int n) { return ngt(n, &gis); }
auto Bv(T)(T[] a, out T v1) { v1 = a[0];  return a[1..$]; }
auto Bv(T)(T[] a, out T v1, out T v2) { v1 = a[0]; v2 = a[1]; return a[2..$]; }
auto Bv(T)(T[] a, out T v1, out T v2, out T v3) { v1 = a[0]; v2 = a[1]; v3 = a[2]; return a[3..$]; }
auto Bv(T)(T[] a, out T v1, out T v2, out T v3, out T v4) { v1 = a[0]; v2 = a[1]; v3 = a[2]; v4 = a[3]; return a[4..$]; }
auto Bv(T)(T[] a, out T v1, out T v2, out T v3, out T v4, out T v5) { v1 = a[0]; v2 = a[1]; v3 = a[2]; v4 = a[3]; v5 = a[4]; return a[5..$]; }
// --------------------------------------------------------------------------
