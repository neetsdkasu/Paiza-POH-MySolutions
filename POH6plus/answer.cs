using System;
using System.Linq;
public class Hello
{
    public static void Main()
    {
        var n = int.Parse(Console.ReadLine());
        var w = new string[n];
        for (var i = 0; i < n; i++)
            w[i] = Console.ReadLine();
        Array.Sort(w);
        string s = "", t = "", c = "";
        for (var i = 0; i < n; i++)
        {
            if (w[i] == "")
            {
                continue;
            }
            var r = new string(w[i].Reverse().ToArray());
            var j = i + 1;
            for (; j < n; j++)
            {
                if (w[j] == r)
                {
                    s += w[i];
                    t = r + t;
                    w[j] = "";
                    break;
                }
            }
            if (j < n)
            {
                continue;
            }
            if (w[i] == r && (c == "" || c.CompareTo(r) > 0))
            {
                c = r;
            }
        }
        Console.WriteLine(s + c + t);
    }
}
