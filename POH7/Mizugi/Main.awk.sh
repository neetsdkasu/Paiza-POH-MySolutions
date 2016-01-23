#!/bin/bash
# Try POH
# author: Leonardone @ NEETSDKASU
#
# よもやこれはBashじゃなくawk
awk '{t=int($1/5);while(t>0){c+=t;t=int(t/5)};r=1;for(i=$1;x=i--;){while(x%5<1)x/=5;if(c>0)while(x%2<1){x/=2;if(--c<1)break}r=r*x%10^9}print r}';
