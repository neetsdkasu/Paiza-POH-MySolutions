/*
 * 結果 https://paiza.jp/poh/joshibato/rio/result/8cb552c4
 */
#include <iostream>

int main() {

    using namespace std;
    
    int n;
    
    cin >> n;
    
    double w(0), c(0);
    
    for (int i = 0; i < n; i++) {
        int t;
        double s;
        cin >> t >> s;
        switch (t) {
        case 1: w += s; break;
        case 2: c += s; break;
        case 3:
            double wc = w + c;
            w = (w * wc - s * w) / wc;
            c = (c * wc - s * c) / wc;
            break;
        }
    }
    
    double ans(100);
    
    ans *= c;
    ans /= w + c;
    
    cout << (int)ans << endl;
    
    return 0;
}
