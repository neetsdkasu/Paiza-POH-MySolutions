main(){long long n,i,r=1,b=0,m=1000000000;scanf("%d",&n);while(i=n--,n){for(;~i&1;i/=2)b++;for(;!(i%5);i/=5)b--;r=(r*i)%m;}while(b--)r=(r*2)%m;printf("%d",r);}
