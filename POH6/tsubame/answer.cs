/*
 * 結果 https://paiza.jp/poh/joshibato/tsubame/result/e5732672
 */
public class answer {
    public static void Main(){
        
        var n_str = System.Console.ReadLine();
        
        var n = int.Parse(n_str);
        var n1 = int.Parse(n_str.Substring(1,1));
        var n10 = int.Parse(n_str.Substring(0,1));
        var r = n + n1 + n10;
        
        System.Console.WriteLine(r);
    }
}
