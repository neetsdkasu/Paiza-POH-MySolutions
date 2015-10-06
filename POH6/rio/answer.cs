/*
 * 結果 https://paiza.jp/poh/joshibato/rio/result/09dbc2d7
 */
using System;

public class answer {
    public static void Main(){
        var n = int.Parse(Console.ReadLine());
        var w = 0.0;
        var c = 0.0;
        for (var i = 0; i < n; i++) {
            var tas = Console.ReadLine().Split(' ');
            var s = double.Parse(tas[1]);
            switch (tas[0]) {
            case "1":
                w += s;
                break;
            case "2":
                c += s;
                break;
            default:
                var wc = w + c;
                w = (w * wc - s * w) / wc;
                c = (c * wc - s * c) / wc;
                break;
            }
            
        }
        var ans = 100.0 * c / (w + c);
        Console.WriteLine((int)ans);
    }
}
