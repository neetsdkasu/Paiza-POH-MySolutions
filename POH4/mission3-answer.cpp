#include <cstdio>

using namespace std;

const int BUFSIZE = 2000000;

char buf[BUFSIZE];
char *pbuf = buf;

int getValue() {
    int value = 0;
    while (*pbuf != '\n' && *pbuf != ' ') {
        value = value * 10 + (int)(*pbuf++ - '0');
    }
    pbuf++;
    return value;
}

int cache[300000];

int main(){
    int maximum = 0;
    int len;
    int n, t, m;
    int i, c = 0;
 
    len = fread(buf, sizeof(char), BUFSIZE, stdin);
    buf[len] = '\n';
 
    t = getValue();
    n = getValue();
 
    for (i = 0; i < n; i++) {
        m = getValue();
        cache[i] = m;
        if (i >= t) {
            c += m - cache[i - t];
        } else {
            c += m;
        }
        if (c > maximum) {
            maximum = c;
        }
    }
 
    printf("%d\n", maximum);
 
    return 0;
}
