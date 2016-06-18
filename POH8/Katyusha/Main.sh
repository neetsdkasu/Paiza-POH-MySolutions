#!/bin/bash
# Try POH 
# author: Leonardone @ NEETSDKASU
# -------------------------------
typeset -i n m c p q x #
read n p #
read m q #
c=$((n * p)) #
x=$((n / m)) #
if ((n % m)); then #
    x=$((x+1)) #
fi #
echo $((c + x * q)) #
