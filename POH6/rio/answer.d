/*
 * 結果 https://paiza.jp/poh/joshibato/rio/result/4ad1ffeb
 */
import io = std.stdio : readln, puts = writeln; // モジュール名をエイリアス、コロン以降のはモジュール名なしで呼び出せる、それ以外はモジュール名のエイリアス必須
import std.format, std.string; // importすればそのモジュール内の関数を呼び出せる
                               // コロンで関数名を指定してないので
                               // モジュール名なしのchomp()でも
                               // モジュール名ありのstd.string.chomp()でもどちらでも呼び出せる？

void main()
{
    int n;
    
    io.readf("%s\n", &n); // %sはどんなタイプでも読み込める便利なやつ、もちろん整数指定の%dを使ってもおｋ
    
    double w = 0.0, c = 0.0;
    
    for (int i = 0; i < n; i++)
    {
        string t;
        double s;
        
        string line = std.string.chomp(readln()) ~ "."; // double値に読み込む場合は小数点が必要らしい…
        formattedRead(line, "%s %s", &t, &s);
        
        switch (t)  // なんと文字列でスイッチ文！
        {
            case "1":
                w += s;
                break;
            
            case "2":
                c += s;
                break;
            
            default:
                double wc = w + c;
                w = (w * wc - s * w) / wc;
                c = (c * wc - s * c) / wc;
                break;
        }
        
    }
    
    import std.math; // std.mathをimportしなければstd.math.floorとしても呼び出せない(std.mathという名前を見つけられないらしいJavaとは違うね)

    auto ans = cast(int)floor(100.0 * c / (w + c)); // 意味もなく方推論
    
    puts(ans); // import文で定義したwritelnのエイリアス
    
}
