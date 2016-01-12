// Try POH
// author: Leonardone @ NEETSDKASU
#include <iostream>

using namespace std;

int main() {
    int q[100][100];
    int p[10][10];
    int n, m;
    
    cin >> n;
    for (int i = 0; i < n; i++)
        for (int j = 0; j < n; j++)
            cin >> q[i][j];
    cin >> m;
    for (int i = 0; i < m; i++)
        for (int j = 0; j < m; j++)
            cin >> p[i][j];
    
    for (int i = 0; i <= n - m; i++)
        for (int j = 0; j <= n - m; j++) {
            int c = 0;
            for (int y = 0; y < m; y++) 
                for (int x = 0; x < m; x++)
                    c |= q[i + y][j + x] ^ p[y][x];
            if (!c)
                cout << i << " " << j << endl;
        }
    
    return 0;    
}
