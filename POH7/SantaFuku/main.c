/* Try POH
 * author: Leonardone @ NEETSDKASU
 */
#include <stdio.h>

#define Min(a,b) ((a)>(b)?(b):(a))
#define Abs(a) (0>(a)?(-(a)):a)

int main(void) {
    int x, y, z, n;
    int xy[2][101] = {{0}};
    int xym[2];
    
    scanf("%d %d %d %d", &x, &y, &z, &n);
    
    xym[0] = x;
    xym[1] = y;
    
    while (n--) {
        int d, a, i;
        scanf("%d %d", &d, &a);
        xy[d][0]++;
        xym[d] = Min(xym[d], Min(xy[d][xy[d][0]] = a, (d?y:x) - a));
        for (i = 1; i < xy[d][0]; i++) {
            xym[d] = Min(Abs(xy[d][i] - a),xym[d]);
        }
    }
    
    printf("%d\n", z * xym[0] * xym[1]);
    
    return 0;
}
