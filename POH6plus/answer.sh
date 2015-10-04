#!/bin/bash

declare -a w
declare -i i j k
declare x

mapfile -t w

for (( i=${w[0]}; i; i--)); do
    k=i
    for (( j=i-1; j; j--)); do
        if [[ ${w[j]} < ${w[k]} ]]; then
            k=j;
        fi;
    done
    x=${w[i]}
    w[i]=${w[k]}
    w[k]=$x;
done

for (( i=${w[0]}; i; i--)); do
    echo "${w[i]}";
done
