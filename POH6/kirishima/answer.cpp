//
// 結果 https://paiza.jp/poh/joshibato/kirishima/result/497729b3
//
#include <iostream>
#include <vector>
#include <algorithm>
#include <string>

int main() {
    
    using std::cin;
    typedef std::vector<int> intvec;
    
    int n, m;

    cin >> n;

    intvec t(n);
    
    for (int i = 0; i < n; i++) {
        cin >> t[i];
    }
    
    cin >> m;
    
    for (int i = 0; i < m; i++) {
        int d;
        intvec f(n, 0);
        std::string r = "No";
        cin >> d;
        for (;;) {
            if (d < 1 || d >= n) break;
            if (d == n - 1) {
                r = "Yes";
                break;
            }
            if (t[d] == 0) break;
            if (f[d]) break;
            f[d] = 1;
            d += t[d];
        }
        std::cout << r << std::endl;
    }
    
    return 0;
}
