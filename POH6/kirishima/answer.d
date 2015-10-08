/+
 + 結果 https://paiza.jp/poh/joshibato/kirishima/result/c6168137
 +/
 
void main() // D言語マニュアル見るとブロック開始の括弧は行頭に置くスタイルぽい、C#と同じやな
{
    import std.stdio : readf;

    int n, m;
    
    readf("%d\n", &n); // フォーマットに改行を入れておかな次のreadln()で%d直後の\nを読んでしまう
    
    import std.stdio : readln;
    import std.string : chomp;
    import std.array: split;
    import std.conv: to;
    
    auto t = to!(int[])(split(chomp(readln()))); // to便利すぎでしょ！
    
    readf("%d\n", &m); // 次で%sを使うからフォーマットに\nを入れないと%sで\nが読まれちゃう！
    
    for (int i = 0; i < m; i++)
    {
        int d;
        readf("%s\n", &d); // なんとなく%sを使ってみますた、%dを使えばフォーマットに\nは必要ないのにね
        string r = "No";
        
        import std.array : array;
        import std.range : repeat;
        auto f = array(repeat(false, n));
        
        for (;;)
        {
            if ((d < 1) || (d >= n)) break;
            if (d == n - 1)
            {
                r = "Yes";  /+ このコメントは /+ ネスト(入れ子)にできるので +/  デバッグに便利！ +/
                break;      /* このコメントは /* ネストにできないので * / ← うっかりネストしたつもりになっちゃダメよ */
            }
            if (t[d] == 0) break;
            if (f[d]) break;
            f[d] = true;
            d += t[d];
        }
        
        import std.stdio : writeln;
        writeln(r);                
    }

}
