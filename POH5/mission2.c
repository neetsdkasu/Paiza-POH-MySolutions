/* author: Leonardone @ NEETSDKASU */
#include <stdio.h>
int main(void){
    int n, i, v;
    int sum[7] = {0};
    
    scanf("%d", &n);
    
    for (i = 0; i < n; i++) {
        scanf("%d", &v);
        sum[i % 7] += v;
    }
    
    for (i = 0; i < 7; i++) {
        printf("%d\n", sum[i]);
    }
    
    return 0;
}
