/* Try POH
 * author: Leonardone @ NEETSDKASU
 */
#include <stdio.h>

#define M 1000000000

int main(void) {
    long long n,i,r=1,b=0;
    scanf("%lld",&n);
    while(i=n--,n){
        for(;~i&1;i/=2)b++;
        for(;!(i%5);i/=5)b--;
        r=(r*i)%M;
    }
    while(b--)r=(r*2)%M;
    printf("%lld\n",r);
    return 0;
}
