// Try POH
// author: Leonardone @ NEETSDKASU
void solve();
int main() { solve(); return 0; }

#include <iostream>

using namespace std;

void solve() {
    
    long long n, r = 1, c = 0, x, md = 1000000000;
    cin >> n;
    while (n > 1) {
        x = n--;
        while (x % 5 == 0) {
            c--; x /= 5;
        }
        while (x % 2 == 0) {
            c++; x /= 2;
        }
        r = (r * x) % md;
    }
    while (c-- > 0)
        r = (r * 2) % md;
    cout << r << endl;
}
