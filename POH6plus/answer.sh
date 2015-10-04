#!/bin/bash

declare -a w
declare -i i j k
declare x rw
declare -f rev

function rev() {
    local -i len=${#1}
    local -i ii
    rw=""
    for (( ii=len; ii; ii--)); do
        rw+=${1:ii-1:1}
    done
}

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
    x=${w[i]}
    rev x
    echo -n $x
    echo -n " - "
    rev ${w[i]}
    echo $rw
done
