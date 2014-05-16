/* paiza POH! vol.2
 * result:
 * http://paiza.jp/poh/paizen/result/49b109cda01f53abda3129b43c143c38
 * author: Leonardone @ NEETSDKASU
 */
#include <cstdio>
using namespace std;

#define OUTPUTSIZE (600000)
char output[OUTPUTSIZE];
char *optr = output;
 
inline void putInt(int v) {
	if (v < 10) {
		*optr = '0' + (char)v;
		++optr;
	} else {
		putInt(v / 10);
		*optr = '0' + (char)(v % 10);
		++optr;
	}
}
 
inline void putNewline() {
	*optr = '\n';
	++optr;
}
 
#define BUFSIZE (900000)
char buf[BUFSIZE];
char *ptr = buf;
 
inline int getInt() {
	int v = 0;
	while (*ptr < '0' || *ptr > '9') ++ptr;
	while (*ptr >= '0' && *ptr <= '9') {
		v = 10 * v + (int)(*ptr - '0');
		++ptr;
	}
	return v;
}
 
inline char getChar() {
	while (*ptr < '0' || *ptr > '9') ++ptr;
	return *ptr++;
}

int space2top[301];
int table[301][301];

typedef int * PINT;

int main() {
	int H, W, N, s, t, i, x, y;
	char str[310];
	PINT p, q;
	
	fread(buf, sizeof(char), BUFSIZE, stdin);
	
	H = getInt();
	W = getInt();
	
	for (y = 0; y < H; ++y) {
		q = space2top + 1;
		for (x = 0; x < W; ++x, ++q) {
			if (getChar() == '0') {
				p = q;
				s = ++(*p);
				t = 1;
				while (*p) {
					if (*p < s) {
						s = *p;
					}
					++table[t][s];
					++t;
					--p;
				}
			} else {
				*q = 0;
			}
		}
	}
	
	for (x = 1; x <= W; ++x) {
		p = table[x] + H;
		for (y = 1; y < H; ++y) {
			--p;
			*p += *(p + 1);
		}
	}
	
	N = getInt();
	
	for (i = 0; i < N; ++i) {
		s = getInt();
		t = getInt();
		putInt(table[t][s]);
		putNewline();
	}
	
	fwrite(output, sizeof(char), (int)optr - (int)output, stdout);
		
	return 0;
}
