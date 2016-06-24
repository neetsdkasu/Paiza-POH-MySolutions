#!/bin/bash
# Try POH 
# author: Leonardone @ NEETSDKASU
# -------------------------------
typeset -i n m x #
typeset -ai t #
read n #
read m #
n=$((n * 60)) #
function slv() {  #
    n=$(($n - $2)) #
    if (($n < 0)); then #
        m=$(($m - 1)) #
    fi #
} #
mapfile -t -c 1 -C slv #
if (($n < 0)); then #
    echo $m #
else #
    echo 'OK' #
fi #
