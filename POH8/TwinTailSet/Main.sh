#!/bin/bash
# Try POH 
# author: Leonardone @ NEETSDKASU
# -------------------------------
typeset -i s t i #
read s #
read t #
for ((i=t-1;i;i--)); do #
    echo -n '-' #
done #
echo -n '+' #
for ((i=s-t;i;i--)); do #
    echo -n '-' #
done #
echo #
