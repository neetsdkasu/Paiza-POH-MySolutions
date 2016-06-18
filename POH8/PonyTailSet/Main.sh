#!/bin/bash
# Try POH 
#author: Leonardone @ NEETSDKASU
typeset -i i c #
c=0 #
for ((i=5;i;i--)); do #
    read a b #
    if [[ $a == $b ]]; then #
        c=$(($c+1)) #
    fi #
done #
if [[ $c < 3 ]]; then #
    echo 'NG' #
else #
    echo 'OK' #
fi #
