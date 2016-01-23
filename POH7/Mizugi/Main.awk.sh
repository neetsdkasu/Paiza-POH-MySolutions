#!/bin/bash
# Try POH
# author: Leonardone @ NEETSDKASU
#
# よもやこれはBashじゃなくawk
awk '{t=$1;while(t=int(t/5))c+=t;r=1;while(x=$1--){while(x%5<1)x/=5;while(x%2<1&&0<c--)x/=2;r=r*x%10^9}print r}';
