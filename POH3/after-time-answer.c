#include <stdio.h>

#define MAX (3000000)

int m, n;
int q[50];
int r[50];
int dp[MAX] = {0};
int tp[MAX] = {0};

int main(void) {
    int i, j;
    int min = 0, t_q, t_r;
    int *x, *y, *z;
   
    scanf("%d", &m);
    scanf("%d", &n);
     
    for (i = 0; i < n; i++) {
        scanf("%d %d", &q[i], &r[i]);
        min += r[i];
    }
   
    x = dp;
    y = tp;
    for (i = 0; i < n; i++) {
        for (j = 0; j < MAX; j++) y[j] = x[j];
        for (j = 0; (j + q[i]) < MAX; j++) {
            if ((x[j] == 0) && (j > 0)) continue;
            t_q = j + q[i];
            t_r = x[j] + r[i];
            if (t_r < x[t_q]) {
                y[t_q] = t_r;
            } else if (x[t_q] == 0) {
                y[t_q] = t_r;
            } else {
                y[t_q] = x[t_q];
            }
            if ((t_q >= m) && (y[t_q] < min)) {
                min = y[t_q];
            }
        }
        z = x;
        x = y;
        y = z;
    }
   
    printf("%d\n", min);
   
    return 0;
}
