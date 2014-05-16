/* paiza POH! Vol.1
 * result:
 * http://paiza.jp/poh/ec-campaign/result/1dc98fdaf8bcee55454a3a458cde8596
 * author: Leonardone @ NEETSDKASU
 */
// C++ g++ 4.7.2
#include <cstdio>
#include <cstdlib>
using namespace std;

int list[500000];

int mysort( const void * a , const void * b ) {
    if (*(int*)a < *(int*)b) {
        return 1;
    } else if (*(int*)a > *(int*)b) {
        return -1;
    } else {
        return 0;
    }
}

inline int g() {
    register int c, n = 0;
    do {
        if ((c = getchar()) == EOF) {
            return -1;
        }
    } while ((c < '0') || (c > '9'));
    do {
        n = n * 10 + (c - '0');
        c = getchar();
    } while ((c >= '0') && (c <= '9'));
    return n;
}

int main() {
    int n, d, m, p;
    int j;
    int sum, tmp;
    int *f, *e, *ed, *cp;
   
    //scanf("%d %d", &n, &d);
    n = g();
    d = g();
   
    f = list;
    for (j = 0; j < n; ++j) {
        //scanf("%d", f + j);
        f[j] = g();
    }
    qsort(list, n, sizeof(int), mysort);
   
    ed = list + n - 1;
    cp = list + (n >> 1);
    //while (0 < scanf("%d", &m)) {
    for (j = 0; j < d; ++j) {
        m = g();
        f = m < *cp ? cp : list;
        e = m - *f > *cp ? cp : ed;
        tmp = 0;
        while (f != e) {
            sum = *f + *e;
            if (sum > m)
                ++f;
            else {
                if (sum > tmp) tmp = sum;
                --e;
            }
        }
        printf("%d\n", tmp);
           
    }

    return 0;
}
