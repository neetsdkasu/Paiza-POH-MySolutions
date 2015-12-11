#include <stdio.h>
#include <string.h>
char q[100][201],p[10][21];i,j,k,n,m,t;main(){scanf("%d\n",&n);for(i=0;i<n;)fgets(q[i++],201,stdin);scanf("%d\n",&m);for(i=0;i<m;)fgets(p[i++],21,stdin);for(i=0;i<=n-m;i++)for(j=0;j<=n-m;j++){t=0;for(k=0;k<m;k++)t+=!!memcmp(q[i+k]+j+j,p[k],m+m-1);if(!t)printf("%d %d\n",i,j);}}
