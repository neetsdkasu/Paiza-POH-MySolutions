// Try POH
// author: Leonardone @ NEETSDKASU
import std.stdio, std.conv, std.array, std.string, std.range, std.algorithm;

void main()
{
    long r = 1, n = gl();
    int c = 0;
    while (n > 1)
    {
        auto x = n--;
        while (x % 5 == 0)
        {
            x /= 5;
            c--;
        }
        while (x % 2 == 0)
        {
            x /= 2;
            c++;
        }
        r = (r * x) % 1000000000;
    }
    while (c-- > 0)
    {  
        r = (r * 2) % 1000000000;
    }
    writeln(r);
}

// --------------------------------------------------------------------------
string   gs()  { return chomp(readln()); }
int      gi()  { return to!int(gs()); }
long     gl()  { return to!long(gs()); }
string[] gss() { return split(gs); }
int[]    gis() { return to!(int[])(gss()); }
T[]      ngt(T)(int n, T function() f) { return array(map!( _ => f() )(iota(0, n))); }
string[] ngs(int n) { return ngt!string(n, &gs); }
int[]    ngi(int n) { return ngt!int(n, &gi); }
string[][] ngss(int n) { return ngt!(string[])(n, &gss); }
int[][]    ngis(int n) { return ngt!(int[])(n, &gis); }
// --------------------------------------------------------------------------
