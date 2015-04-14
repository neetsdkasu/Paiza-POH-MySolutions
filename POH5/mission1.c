/* author: Loenardone @ NEETSDKASU */
#include <stdio.h>

int main(void){
    int c, i;
    
    for (i = 0; (c = getchar()) != EOF; i++) {
        if (i & 1) continue;
        putchar(c);
    }
    putchar('\n');
    
    return 0;
}
