#!/bin/bash
# Try POH 
# author: Leonardone @ NEETSDKASU
# -------------------------------
typeset -i i j k t c x #
typeset -a a #
typeset -ai r #
read -a a #
k=100 #
t=0 #
x=1 #
for ((i=0;i<52;i++)); do #
    for ((j=0;j<52;j++)); do #
        if ((k == j)); then #
            k=100 #
            t=0 #
        fi #
        if [[ ${r[$j]} -gt 0 ]]; then #
            continue #
        fi #
        ch=${a[$j]} #
        case $ch in #
            'J') c=11 ;; #
            'Q') c=12 ;; #
            'K') c=13 ;; #
            'A') c=14 ;; #
            '2') c=15 ;; #
            $ch) c=$ch ;; #
        esac #
        if ((c <= t)); then #
            continue #
        fi #
        k=$j #
        t=$c #
        r[$j]=$x #
        x=$((x+1)) #
    done #
done #
for ((i=0;i<52;i++)); do #
    echo ${r[$i]} #
done #
