/*
 * 結果 https://paiza.jp/poh/joshibato/rio/result/88bb4895
 */
#include <iostream>

int main() {

    using namespace std;
    
    int n;
    
    cin >> n;
    
    long double w(0), c(0);
    
    for (int i = 0; i < n; i++) {
        int t;
        long double s;
        cin >> t >> s;
        switch (t) {
        case 1: w += s; break;
        case 2: c += s; break;
        case 3:
            long double wc = w + c;
            w = (w * wc - s * w) / wc;
            c = (c * wc - s * c) / wc;
            break;
        }
    }
    
    long double ans(100);
    
    ans *= c;
    ans /= w + c;
    
    cout << (int)ans << endl;
    
    return 0;
}
