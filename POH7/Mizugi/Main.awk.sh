#!/bin/bash
# Try POH
# author: Leonardone @ NEETSDKASU

# よもやこれはBashじゃなくawk
awk '{
c=0;
t=int($1/5);
while(t>0){
    c+=t;
    t=int(t/5)
};
r=1;
for(i=1;i<=$1;i++){
    x=i;
    while(x%5==0){
        x=int(x/5)
    };
    if(c>0){
        while(x%2==0){
            x=int(x/2);
            c--;
            if(c==0){break}
        }
    };
        r=(r*x)%1000000000;
    };
print r
}'
