/*
 * 結果 https://paiza.jp/poh/joshibato/rio/result/52c1ba56
 */
#include <stdio.h>

typedef struct _dd {
    int a;
    int b;
} DD;

const DD ZERO = {0, 1};
const DD ONE = {1, 1};

DD cast(const int v) {
    DD r = {v, 1};
    return r;
}

int GCD(int x, int y) {
    if (x == 0) {
        return y;
    }
    if (y == 0) {
        return x;
    }
    if (x > y) {
      return GCD(x % y, y);
    } else {
      return GCD(y % x, x);
    }
}

DD gcd(DD x) {
    int d = GCD(x.a, x.b);
    x.a /= d;
    x.b /= d;
    return x;
}

DD add(DD x, DD y) {
    if (x.b == y.b) {
        x.a += y.a;
    } else {
        x.a = x.a * y.b + x.b * y.a;
        x.b *= y.b;
    }
    return gcd(x);
}

DD sub(DD x, DD y) {
    y.a = -y.a;
    return add(x, y);
}

DD mul(DD x, DD y) {
    x.a *= y.a;
    x.b *= y.b;
    return gcd(x);
}

DD div(DD x, DD y) {
    x.a *= y.b;
    x.b *= y.a;
    return gcd(x);
}

int main(void){
 
    DD x = ZERO, y = ZERO;
    int n, i;
 
    scanf("%d", &n);
 
    for (i = 0; i < n; i++) {
        int t, s;
        DD xy, ss;
        scanf("%d %d", &t, &s);
        ss = cast(s);
        switch (t) {
            case 1:
                x = add(x, ss);
                break;
            case 2:
                y = add(y, ss);
                break;
            case 3:
                xy = add(x, y);
                x = sub(x, div(mul(ss, x), xy));
                y = sub(y, div(mul(ss, y), xy));
                break;
        }
    }
 
    {
        DD p = mul(cast(100), div(y, add(x, y)));
        printf("%d", p.a / p.b);
    }
     
    return 0;
}
