// Try POH
// author: Leonardone @ NEETSDKASU
using System;
using System.Linq;

public class Solver
{
    public static void Main()
    {
        long r = 1, n = gl();
        int c = 0;
        
        while (n > 1)
        {
            var x = n--;
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
        
        Console.WriteLine(r);
    }
    
    ///////////////////////////////////////////////////////////////////
    static string   gs()  { return Console.ReadLine(); }
    static int      gi()  { return int.Parse(gs()); }
    static long     gl()  { return long.Parse(gs()); }
    static string[] gss() { return gs().Split(" ".ToCharArray()); }
    static int[] gis() { return gss().Select( int.Parse ).ToArray(); }
}
