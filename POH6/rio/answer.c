/*
 * 結果 https://paiza.jp/poh/joshibato/rio/result/338ee274
 */
#include <stdio.h>
#include <math.h>

int main(void) {
    int n, i, t, ans;
    long double w, c, s, wc;
    
    scanf("%d", &n);
    
    w = 0.0L;
    c = 0.0L;
    
    for (i = 0; i < n; i++) {
        scanf("%d %Lf", &t, &s);
        switch (t) {
        case 1:
            w += s;
            break;
        case 2:
            c += s;
            break;
        case 3:
            wc = w + c;
            w = (w * wc - s * w) / wc;
            c = (c * wc - s * c) / wc;
            break;
        }
    }
    
    ans = (int)floor((double)(100.0L * c / (w + c)));
    
    printf("%d\n", ans);
    
    return 0;
}
