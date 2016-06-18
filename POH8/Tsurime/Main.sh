#!/bin/bash
# Try POH 
# author: Leonardone @ NEETSDKASU
# -------------------------------
typeset -i p #
read p #
p=$((p / 100)) #
if (($p >= 10)); then #
    p=$((p+10)) #
fi #
echo $p #
