long long n,i,r=1,b,m=1000000000;main(){scanf("%d",&n);for(;i=n--,n;r=r*i%m){for(;~i&1;i/=2)b++;for(;!(i%5);i/=5)b--;}while(b--)r=r*2%m;printf("%d",r);}
