#!/bin/bash
# Try POH
# author: Leonardone @ NEETSDKASU
declare -i n c t r i x j;
read n;
c=0;
t=$(( n / 5 ));
while (( t > 0 )); do #
    let c+=t;
    t=$(( t / 5 ));
done;
r=1;
j=5;
for ((i=1;i<=n;i++)); do #
    x=$i;
    if let --j; then #
        while (( (x % 5) == 0 )); do #
            x=$(( x / 5));
        done;
        j=5;
    fi;
    if (( c > 0 )); then #
        while (( (x & 1) == 0 )); do #
            x=$(( x >> 1 ));
            if (( --c == 0 )); then #
                break;
            fi;
        done;
    fi;
    r=$(( (r * x) % 1000000000 ));
done;
echo $r;
