#!/bin/bash
# Try POH 
# author: Leonardone @ NEETSDKASU
# -------------------------------
typeset -i n i j k p t #
typeset -ai a #
read n #
read -a a #
for ((i=n;i;i--)); do #
    k=$(($i-1)) #
    for ((j=i-1;j;j--)); do #
        p=$((j-1)) #
        if ((${a[$k]} > ${a[$p]})); then #
            k=$p #
        fi #
    done #
    p=$((i-1)) #
    t=${a[$k]} #
    a[$k]=${a[$p]} #
    a[$p]=$t #
done #
p=$(((n+1)/2-1)) #
echo ${a[$p]} #
