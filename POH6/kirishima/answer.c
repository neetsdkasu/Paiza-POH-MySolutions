/*
 * 結果 https://paiza.jp/poh/joshibato/kirishima/result/9185872e
 */
#include <stdio.h>
int main(void){
   
    int mass[100] = {0};
    int n, m;
    int i;
   
    scanf("%d", &n);
   
    for (i = 0; i < n; i++) {
        scanf("%d", &mass[i]);
    }

    scanf("%d", &m);
   
    for (i = 0; i < m; i++) {
        int flag[100] = {0};
        int d;
        scanf("%d", &d);
        while (d > 0 && d < n && mass[d] != 0 && flag[d] == 0) {
            flag[d] = 1;
            d += mass[d];
        }
        if (d == n - 1) {
            puts("Yes");
        } else {
            puts("No");
        }
    }
   
    return 0;
}
