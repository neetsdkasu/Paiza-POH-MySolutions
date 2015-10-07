/*
 * 結果 https://paiza.jp/poh/joshibato/rio/result/eb379198
 */
#include <stdio.h>
#include <math.h>

int main(void) {
    int n, i, t, ans;
    double w, c, s, wc;
    
    scanf("%d", &n);
    
    w = 0.0;
    c = 0.0;
    
    for (i = 0; i < n; i++) {
        scanf("%d %lf", &t, &s);
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
    
    ans = (int)floor(100.0 * c / (w + c));
    
    printf("%d\n", ans);
    
    return 0;
}
