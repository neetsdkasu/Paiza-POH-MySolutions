#!/bin/bash
# Try POH 
# author: Leonardone @ NEETSDKASU
# -------------------------------
typeset -i n t x y d c b #
typeset s #
read n #
c=0 #
x=0 #
b=0 #
for ((;n;n--)); do #
    read t s #
    if (( $x > 0 )); then #
        d=$((t - b)) #
        y=$((d > x ? 0 : x - d)) #
        c=$((c + x - y)) #
        x=$y #
    fi #
    b=$t #
    if [[ $s == 'out' ]]; then #
        x=$((x + 3)) #
    else #
        x=$((x + 5)) #
    fi #
done #
if (( $x > 0 )); then #
    d=$((24 - b)) #
    y=$((d > x ? 0 : x - d)) #
    c=$((c + x - y)) #
    x=$y #
fi #
echo $((c + 24)) #
