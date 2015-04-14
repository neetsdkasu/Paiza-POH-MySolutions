/* author: Leonardone @ NEETSDKASU */
#include <stdio.h>
int main(void){
    int x, y, c, i, j;
    int row[20] = {0};
    
    scanf("%d %d", &x, &y);
    
    for (i = 0; i < y; i++) {
        for (j = 0; j < x; j++) {
            scanf("%d", &c);
            row[j] += c % 2;
        }
    }
    
    for (i = 0; i < y; i++) {
        for (j = 0; j < x; j++) {
            if (j > 0) {
                putchar(' ');
            }
            if (row[j] == y - i) {
                putchar('1');
                row[j]--;
            } else {
                putchar('0');
            }
        }
        putchar('\n');
    }
    
    return 0;
}
