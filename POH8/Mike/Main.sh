#!/bin/bash
# Try POH 
# author: Leonardone @ NEETSDKASU
# -------------------------------
typeset -i n m c #
read n #
read m #
c=$((m / (n * 2))) #
if ((m % (n * 2))); then #
    c=$((c+1)) #
fi #
echo $c #
