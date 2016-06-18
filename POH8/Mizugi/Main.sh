#!/bin/bash
# Try POH 
# author: Leonardone @ NEETSDKASU
# -------------------------------
typeset -i n m i x #
typeset -A a b #
read n m #
read s #
read t #
for ((i=n;i;i--)); do #
    c=${s:i-1:1} #
    a[$c]=$((a[$c]+1)) #
done #
for ((i=m;i;i--)); do #
    c=${t:i-1:1} #
    b[$c]=$((b[$c]+1)) #
done #
x=0 #
r='abcdefghijklmnopqrstuvwxyz' #
for ((i=26;i;i--)); do #
    c=${r:i-1:1} #
    if [[ ${b[$c]} -gt 0 ]]; then #
        k=$((${a[$c]} - ${b[$c]})) #
        if [[ k -lt 0 ]]; then #
            x=$(($x-$k)) #
        fi #
    fi #
done #
echo $x #
