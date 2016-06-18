#!/bin/bash
# Try POH 
# author: Leonardone @ NEETSDKASU
# -------------------------------
typeset -i n m #
read n m #
if (( m % n )); then #
    echo 'ng' #
else #
    echo 'ok' #
fi #
