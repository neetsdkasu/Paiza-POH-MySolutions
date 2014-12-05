/* paiza POH! Lite
* result:
*
* author: Leonardone @ NEETSDKASU
*/
#include <stdio.h>
#include <stdlib.h>

typedef struct _data {
    int q;
    int r;
    double p;
    int f;
} DATA, *PDATA;

int sort_p(void *a, void *b) {
    PDATA pa = (PDATA)a;
    PDATA pb = (PDATA)b;
    double d = pa->p - pb->p;
    if (d > 0) {
        return 1;
    } else if (d < 0) {
        return -1;
    } else {
        return 0;
    }
}

int sort_q(void *a, void *b) {
    PDATA pa = (PDATA)a;
    PDATA pb = (PDATA)b;
    return pb->q - pa->q;
}

int all_q, all_r;
DATA data[100];

void foo(int m, int n) {
    int a0, a1, b0, b1, c0;
    int min, sum_q, sum_r;
    int i;

    if (n > 25) {
        b0 = 0;
        b1 = 1 << (n - 25);
    } else {
        b0 = 1 << n;
        b1 = 0;
    }

    a0 = 1;
    a1 = 0;
    c0 = 1 << 25;
    min = 250000000;
    for (;;) {
        if (a1 > b1) {
            break;
        } else if (a1 == b1 && a0 > b0) {
            break;
        }
        if (a0 == c0) {
            a0 = 0;
            a1++;
        }
        sum_q = sum_r = 0;
        for (i = 0; i < 25; i++) {
            if ((a0 >> i) & 1) {
                sum_q += data[i].q;
                sum_r += data[i].r;
                }
            if ((a1 >> i) & 1) {
                sum_q += data[i + 25].q;
                sum_r += data[i + 25].r;
            }
        }
        if (sum_q >= m && sum_r < min) {
            min = sum_r;
        }
        a0++;
    }
    printf("%d\n", min);
}

void bar(int m, int n, int d) {
    int a0, a1, b0, b1, c0;
    int min, sum_q, sum_r;
    int i;

    if (n > 25) {
        b0 = 0;
        b1 = 1 << (n - 25);
    } else {
        b0 = 1 << n;
        b1 = 0;
    }

    a0 = 1;
    a1 = 0;
    c0 = 1 << 25;
    min = 250000000;
    for (;;) {
        if (a1 > b1) {
            break;
        } else if (a1 == b1 && a0 > b0) {
            break;
        }
        if (a0 == c0) {
            a0 = 0;
            a1++;
        }
        sum_q = sum_r = 0;
        for (i = 0; i < 25; i++) {
            if ((a0 >> i) & 1) {
                sum_q += data[i + d].q;
                sum_r += data[i + d].r;
                }
            if ((a1 >> i) & 1) {
                sum_q += data[i + d + 25].q;
                sum_r += data[i + d + 25].r;
            }
        }
        if (all_q - sum_q >= m && all_r - sum_r < min) {
            min = all_r - sum_r;
        }
        a0++;
    }
    printf("%d\n", min);
}


int main(void) {
   
    int m, n;
    PDATA pdata = data;
    int i, j, k;
    int sum_q, sum_r;
   
    scanf("%d", &m);
    scanf("%d", &n);
   
    for (i = 0; i < n; i++) {
        scanf("%d %d", &pdata->q, &pdata->r);
        all_q += pdata->q;
        all_r += pdata->r;
        pdata->p = (double)pdata->r / (double)pdata->q;
        pdata++;
    }
   
    qsort(data, n, sizeof(DATA), sort_p);
   
    sum_q = sum_r = 0;
    pdata = data;
    for (i = 0; i < n; i++) {
        sum_q += pdata->q;
        sum_r += pdata->r;
        pdata->f = 1;
        if (sum_q >= m) {
            break;
        }
        pdata++;
    }
   
    if (n - i > i) {
        i += 3;
        foo(m, i > n ? n : i);
    } else {
        i -= 5;
        if (i < 0) {
            i = 0;
        }
        bar(m, n - i, i);   
    }
   
    return 0;
}
