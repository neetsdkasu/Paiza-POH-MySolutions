#!/bin/bash
# Try POH
# author: Leonardone @ NEETSDKASU
declare -i n m i j k f j2 m2 nm;
declare -a p q;
read n;
mapfile -t -n $n p;
read m;
mapfile -t -n $m q;
m2=$(( m * 2 - 1 ));
nm=$(( (n - m) * 2 ));
for ((i=n-m;i>=0;i--)); do #
    for ((j=nm;j>=0;j-=2)); do #
        for ((k=0;k<m;k++)); do #
            if [[ ${q[k]} != ${p[i+k]:j:m2} ]]; then #
                continue 2;
            fi;
        done;
        j=$(( j / 2 ));
        echo "$i $j";
        exit 0;
    done;
done;
