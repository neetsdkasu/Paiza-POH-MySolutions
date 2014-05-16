/* paiza POH! Vol.1
 * result:
 * http://paiza.jp/poh/ec-campaign/result/7712b5305e22862e2d41039cd4448c23
 * author: Leonardone @ NEETSDKASU
 */
#include <stdio.h>
#include <stdlib.h>
#define PMAX (1000000)
#define PC(c) putchar(c)
#define PD(d) printf("%d\n", d)
#define PS(s) printf("%s\n", s)
#define SUMCHECK(tmp, sum, i, u, m) \
	sum = i + u; \
	if (sum > tmp) { \
		tmp = sum; \
		if (tmp == m) break; \
	}

char inputs[5000000] = {0};
int list[PMAX + 1] = {0};
char str[10] = {'\n'};
char *inp = inputs;

inline int gc(void) {
    register int c, n = 0;
    do {
        c = (int)*inp;
        ++inp;
    } while ((c < '0') || (c > '9'));
    do {
        n = n * 10 + (c - '0');
        c = (int)*inp;
        ++inp;
    } while ((c >= '0') && (c <= '9'));
    return n;
}

inline void pi(register int n) {
	register int t, i = 1;
	do {
		t = n / 10;
		str[i] = n - t * 10 + '0';
		++i; n = t;
	} while (n > 0);
	do {
		PC(str[--i]);
	} while (i);
}

int main(void) {
    register int j, i, u, sum, tmp;
    int n, d, m, p, lm;
    
    fread(inputs, sizeof(char), 5000000, stdin);
    
    n = gc();
    d = gc();
    
    j = n + 1;
    while (--j) {
        ++list[gc()];
    }
    
    ++list[PMAX];
    ++list[9];
    ++list[0];
    j = d + 1;
    while (--j) {
        i = (m = gc()) - 1;
        u = 10;
        tmp = 0;
        while(!list[i]) --i;
        if (i > 9) {
        	lm = m >> 1;
        	do {
        		if ((u = m - i) > i) break;
        		if (u > 9) {
	        		if (i == u) {
	        			if (list[i] > 1) {
	        				SUMCHECK(tmp, sum, i, u, m);
	        			} else {
	        				--u;
		        			while (!list[u]) --u;
		        			if (u > 9) {
		        				SUMCHECK(tmp, sum, i, u, m);
		        			}
	        			}
	        		} else {
	        			while (!list[u]) --u;
	        			if (u > 9) {
	        				SUMCHECK(tmp, sum, i, u, m);
	        			}
	        		}
        		}
        		--i;
        		while (!list[i]) --i;
        	} while (i >= lm);
        }
        pi(tmp);
    }
    
    return 0;
}

