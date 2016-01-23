#!/bin/bash
# Try POH
# author: Leonardone @ NEETSDKASU
declare -i n m i j k f j2 m2;
declare -a p q;
read n;
mapfile -t -n $n p;
read m;
mapfile -t -n $m q;
m2=$(( m * 2 - 1 ));
for ((i=0;i<=n-m;i++)); do #
    for ((j=0;j<=n-m;j++)); do #
        j2=$(( j * 2 ));
        for ((k=0;k<m;k++)); do #
            if [[ ${q[k]} != ${p[i+k]:j2:m2} ]]; then #
                continue 2;
            fi;
        done;
        echo "$i $j";
        exit 0;
    done;
done;
