/* paiza POH! Lite
* result:
*
* author: Leonardone @ NEETSDKASU
*/
#include <stdio.h>
#include <stdlib.h>

typedef struct _data {
    int q;
    int r;
} DATA, *PDATA;

int a[51][500001];
DATA data[51];

int main(void) {
   
    int m;
    int n;
   
    int w = 0, p = 0;
   
    int i, j, x, y;
   
    scanf("%d", &m);
    scanf("%d", &n);
   
    for (i = 0; i < n; i++) {
        scanf("%d %d", &data[i].q, &data[i].r);
        w += data[i].q;
        p += data[i].r;
    }
    w -= m;
   
    for (i = 0; i < n; i++) {
        for (j = 0; j <= w; j++) {
            if (data[i].q <= j) {
                x = a[i][j];
                y = a[i][j - data[i].q] + data[i].r;
                a[i + 1][j] = (x > y) ? x : y;
            } else {
                a[i + 1][j] = a[i][j];
            }
        }
    }
   
    printf("%d\n", p - a[n][w]);
   
    return 0;   
}
