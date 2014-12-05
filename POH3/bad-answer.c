/* paiza POH! Lite
* result:
*
* author: Leonardone @ NEETSDKASU
*/
#include <stdio.h>
#include <stdlib.h>

/* 全通りの組み合わせから条件に符合する答えを求める */
#define SEEK(I, Q, R)                        \
    {                                        \
        b = 1LL << nn;                        \
        for (;;) {                            \
            if (a > b) {                      \
                break;                        \
            }                                \
            sum_q = sum_r = 0;                \
            for (i = 0; i < n; i++) {        \
                if ((a >> i) & 1LL) {        \
                    sum_q += data[(I)].q;    \
                    sum_r += data[(I)].r;    \
                }                            \
            }                                \
            if (((Q) >= m) && ((R) < min)) {  \
                min = (R);                    \
            }                                \
            a++;                              \
        }                                    \
    }


/* 1社ごとの情報 */
typedef struct _data {
    int q; /* 動員人数 */
    int r; /* 費用 */
    double p; /* 1人あたりの人件費 */
} DATA, *PDATA;

/* 1人あたりの人件費を昇順(安い順)でソート */
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

int main(void) {
   
    int m; /* 必要な人数 */
    int n; /* 会社の数 */
    DATA data[50]; /* 全n社の各社の人数と費用 */
   
    PDATA pdata;
    int i;

    int all_q = 0; /* 全n社の人数の合計 */
    int all_r = 0; /* 全n社の費用の合計 */

    int sum_q, sum_r, min, d, nn;
    long long a, b;
   
    scanf("%d", &m);
    scanf("%d", &n);
   
    pdata = data;
    for (i = 0; i < n; i++) {
        scanf("%d %d", &pdata->q, &pdata->r);
        pdata->p = (double)pdata->r / (double)pdata->q;
        all_q += pdata->q;
        all_r += pdata->r;
        pdata++;
    }
   
    qsort(data, n, sizeof(DATA), sort_p);
   
    /* 人件費の割安な会社から順に人数を合計し */
    /* 合計人数が初めてm以上になる位置を求める */
    sum_q = sum_r = 0;
    pdata = data;
    for (i = 0; i < n; i++) {
        sum_q += pdata->q;
        sum_r += pdata->r;
        if (sum_q >= m) {
            break;
        }
        pdata++;
    }
   
    min = 250000000;
    a = 1LL;
   
    if (n - i > i) {
        /* 求めた割安な会社数が全n社の半分より少ないとき */
        /* 割安な会社をさらに3社追加し */
        /* 割高な会社は絶対使わないだろうと決め付け */
        /* その中で全通りの組み合わせを求め 条件に符号する結果を得る */
        d = i + 3;
        nn = d > n ? n : d;
        SEEK(i, sum_q, sum_r);
    } else {
        /* 求めた割安な会社数が全n社の半分より多いとき */
        /* 前者とは逆に使わない割高の会社の組み合わせから結果を求める */
        /* 求めた割安な会社数から5社を除いた会社を絶対使うだろうと決め付け */
        /* 割高な会社で全通りの組み合わせを求め 条件に符号する結果を得る */
        d = i - 5;
        if (d < 0) {
            d = 0;
        }
        nn = n - d;
        SEEK(i + d, all_q - sum_q, all_r - sum_r);
    }

    printf("%d\n", min);

    return 0;
}
