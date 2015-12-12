var r=1,b=1,m=1000000000;for i in 1...Int(readLine()!)!{r*=i;while r%2<1{r/=2;b++};while r%5<1{r/=5;b--};r%=m};while --b>0{r=r*2%m};print(r)
