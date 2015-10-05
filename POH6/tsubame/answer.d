//
// 結果 https://paiza.jp/poh/joshibato/tsubame/result/62a1085b
//
import std.stdio;

void main() {
    int n, n1, n10, r;
    
    readf("%d", &n);
    
    n1 = n % 10;
    n10 = (n - n1) / 10;
    
    r = n + n1 + n10;
    
    writeln(r);
}
