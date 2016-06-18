#!/bin/bash
# Try POH 
# author: Leonardone @ NEETSDKASU
# -------------------------------
typeset -i n m #
read m n #
if (( m - n > 0 )); then #
    echo $((m - n)) #
else #
    echo 0 #
fi #
