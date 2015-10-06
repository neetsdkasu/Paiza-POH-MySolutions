/*
 * 結果 https://paiza.jp/poh/joshibato/kirishima/result/32185cf0
 */
using C=System.Console;
public class answer
{
    public static void Main()
    {
        var n = int.Parse(C.ReadLine());
        var t_str = C.ReadLine().Split(' ');
        var t = new int[n];
        for (var i = 0; i < n; i++)
        {
            t[i] = int.Parse(t_str[i]);
        }
        var m = int.Parse(C.ReadLine());
        
        for (var i = 0; i < m; i++)
        {
            var d = int.Parse(C.ReadLine());
            var f = new bool[n];
            var r = "No";
            for (;;) {
                if (d < 1 || d >= n) break;
                if (d == n - 1) {
                    r = "Yes";
                    break;
                }
                if (t[d] == 0) break;
                if (f[d]) break;
                f[d] = true;
                d += t[d];
            }
            C.WriteLine(r);
        }
    }
}
