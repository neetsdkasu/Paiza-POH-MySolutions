#include <stdio.h>
#include <string.h>
#define N 201
char q[N][N],p[N][N];i,j,k,n,m,t;main(){scanf("%d\n",&n);for(i=0;i<n;)fgets(q[i++],N,stdin);scanf("%d\n",&m);for(i=0;i<m;)fgets(p[i++],N,stdin);for(i=0;i<=n-m;i++)for(j=0;j<=n-m;j++){t=0;for(k=0;k<m;k++)t+=!!memcmp(q[i+k]+j+j,p[k],m+m-1);if(!t)printf("%d %d\n",i,j);}}
