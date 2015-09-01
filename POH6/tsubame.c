#include <stdio.h>
int main(void){
    int N;
    scanf("%d", &N);
    printf("%d\n", N + (N % 10) + (int)(N / 10));
   
    return 0;
}
