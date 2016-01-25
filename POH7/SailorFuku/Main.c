/* Try POH
 * author: Leonardone @ NEETSDKASU
 ************************************************************************/
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>
#include <math.h>
/************************************************************************/
#define MR__BUFSIZE (1000000)
typedef struct _string { size_t len; char *data; } string;
char mr__buffer[MR__BUFSIZE], *mr__start=mr__buffer; size_t mr__buflen; void solve(void);
int main(void) { mr__buflen = fread(mr__buffer, sizeof(mr__buffer[0]), sizeof(mr__buffer) / sizeof(mr__buffer[0]), stdin);
    if (mr__buflen < MR__BUFSIZE - 1) mr__buffer[mr__buflen] = '\n'; else exit(EXIT_FAILURE); solve(); return 0; }
#define MAX(a,b) ((a)>(b)?(a):(b))
#define MIN(a,b) ((a)<(b)?(a):(b))
#define rep(i,s,e) for(i=s;i<e;i++)
#define REP(i,e)   rep(i,0,e)
#define Bv2(a,v1,v2)      ;(v1)=(a)[0];(v2)=(a)[1];
#define Bv3(a,v1,v2,v3)   ;Bv2(a,v1,v2);(v3)=(a)[2];
#define Dv2(t,a,v1,v2)    ;t v1,v2;Bv2(a,v1,v2)
#define Dv3(t,a,v1,v2,v3) ;t v1,v2,v3;Bv2(a,v1,v2,v3)
#define V_ALLOCSIZE (20)
typedef struct _vector { size_t size; size_t capa; char data[0]; } VectorT, *Vector, **PPVector;
Vector newVec(size_t n, size_t b) { size_t a=MAX(V_ALLOCSIZE,n);Vector r=(Vector)calloc(1,a*b+sizeof(VectorT)); r->size=n; r->capa=a; return r; }
void extendVec(PPVector p, size_t b) { Vector v=*p;if(v->size==v->capa){v->capa+=V_ALLOCSIZE; v=*p=(Vector)realloc(*p,v->capa*b+sizeof(VectorT));}}
#define CUP(a, b) a##b
#define CUP3(a, b, c) a##b##c
#define VEC_DEF(_T,_I) \
    typedef struct CUP3(_,_I,vector) { size_t size; size_t capa; _T value[0]; } CUP(_I,VectorT),*CUP(_I,Vector),**CUP3(PP,_I,Vector); \
    CUP(_I,Vector) CUP3(new,_I,V)(size_t n) { return (CUP(_I,Vector))newVec(n,sizeof(_T)); } \
    CUP(_I,Vector) CUP3(add,_I,V)(CUP3(PP,_I,Vector) p, _T x) { extendVec((PPVector)p, sizeof(_T)); (*p)->value[(*p)->size++]=x; return *p; }
VEC_DEF(int,I); VEC_DEF(string,S); VEC_DEF(IVector,IV); VEC_DEF(SVector,SV); VEC_DEF(char,C);
SVector strsplit(string str, char d) {SVector vec=newSV(0);char *e=str.data,*s;string t;
    for(;;){s=e;while(*e&&*e!=d)e++;if(e==str.data)return vec;t.data=s;t.len=e-s;addSV(&vec,t);if(*e==0)break;*e++=0;}return vec;}
string strjoin(SVector v,char d){string t,r={0};int i;for(i=0;i<v->size;i++)r.len+=v->value[i].len;if(d)r.len+=v->size-1;
    {char *p=r.data=(char*)malloc(sizeof(char)*(r.len+1));for(i=0;i<v->size;i++)
    {if(i&&d)*p++=d;t=v->value[i];memcpy(p,t.data,t.len*sizeof(char));p+=t.len;}r.data[r.len]=0;}return r;}
int     isEOF(void) { return *mr__start == '\0'; }
void    nextLine(void) { while (*mr__start != '\n') mr__start++; *mr__start++ = '\0'; }
int     ti(string s) { int i,r=0,m=*s.data=='-'; for(i=m;i<(int)s.len;i++)r=r*10+(int)(s.data[i]-'0'); return m ? -r : r; }
string  gs(void) { string r = {0, mr__start}; nextLine(); r.len = mr__start - r.data - 1; return r; }
int     gi(void) { return ti(gs()); }
SVector gss(void) { return strsplit(gs(), ' '); }
IVector gis(void) { SVector v=gss();IVector r=newIV(v->size);int i;for(i=0;i<v->size;i++)r->value[i]=ti(v->value[i]);free(v);return r;}
SVector ngs(int n) { SVector r=newSV(n); int i; for(i=0;i<n;i++)r->value[i]=gs(); return r; }
IVector ngi(int n) { IVector r=newIV(n); int i; for(i=0;i<n;i++)r->value[i]=gi(); return r; }
SVVector ngss(int n) { SVVector r=newSVV(n); int i; for(i=0;i<n;i++)r->value[i]=gss(); return r; }
IVVector ngis(int n) { IVVector r=newIVV(n); int i; for(i=0;i<n;i++)r->value[i]=gis(); return r; }
/************************************************************************/

void solve(void) {
    
    int n = gi();
    SVector s = ngs(n);
    
    puts(strjoin(s, '_').data);

}
