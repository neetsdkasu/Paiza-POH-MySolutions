#include <stdio.h>
#include <string.h>
char q[100][201],p[10][21],*s="%d %d\n";i,j,k,n,m,t;main(){scanf(s+3,&n);for(i=0;i<n;)gets(q+i++);scanf(s+3,&m);for(i=0;i<m;)gets(p+i++);for(i=0;i<=n-m;i++)for(j=0;j<=n-m;j++){t=0;for(k=0;k<m;k++)t+=!!memcmp(q[i+k]+j+j,p+k,m+m-1);if(!t)printf(s,i,j);}}
