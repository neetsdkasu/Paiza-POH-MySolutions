/* author: Leonardone @ NEETSDKASU */
#include <stdio.h>

int table[1000][1000];

int main(void){
    int x, y, n, i, j, k;
    int xs, ys, xe, ye;
    int sum = 0;
    
    scanf("%d %d %d", &x, &y, &n);
    
    for (i = 0; i < y; i++) {
        for (j = 0; j < x; j++) {
            scanf("%d", &table[i][j]);
        }
    }
    
    for (k = 0; k < n; k++) {
        scanf("%d %d %d %d", &xs, &ys, &xe, &ye);
        for (i = ys - 1; i < ye; i++) {
            for (j = xs - 1; j < xe; j++) {
                sum += table[i][j];
                table[i][j] = 0;
            }
        }
    }
    
    printf("%d\n", sum);
    
    return 0;
}
