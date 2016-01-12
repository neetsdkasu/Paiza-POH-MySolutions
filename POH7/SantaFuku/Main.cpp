// Try POH
// author: Leonardone @ NEETSDKASU
#include <iostream>
#include <algorithm>
#include <vector>

using namespace std;

int main() {
    vector<int> xs, ys;
    int x, y, z, n;
    
    cin >> x >> y >> z >> n;
    
    xs.push_back(0); xs.push_back(x);
    ys.push_back(0); ys.push_back(y);
    
    for (int i = 0; i < n; i++) {
        int d, a;
        cin >> d >> a;
        if (d) ys.push_back(a);
        else xs.push_back(a);
    }
    
    sort(xs.begin(), xs.end());
    sort(ys.begin(), ys.end());
    
    int minx = x, miny = y;
    
    for (int i = 1; i < xs.size(); i++)
        minx = min(xs[i] - xs[i - 1], minx);
    for (int i = 1; i < ys.size(); i++)
        miny = min(ys[i] - ys[i - 1], miny);
    
    cout << (minx * miny * z) << endl;
    
    return 0;
}
