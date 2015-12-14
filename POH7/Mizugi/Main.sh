#!/bin/bash
# Try POH
# author: Leonardone @ NEETSDKASU
typeset -i n i j k b r;
read n;
r=1;
b=0;
for ((i=$n; $i; i--)); do { j=$i;
    for ((;;)); do { p=$(($j % 2));
        if [[ $p -gt 0 ]]; then break; fi;
        j=$(($j / 2));
        b=$(($b + 1));
    }; done;
    for ((;;)); do { p=$(($j % 5));
        if [[ $p -gt 0 ]]; then break; fi;
        j=$(($j / 5));
        b=$(($b - 1));
    }; done;
    r=$((($r * $j) % 1000000000));
}; done;
for ((i=$b; $i; i--)); do r=$((($r * 2) % 1000000000)); done;
echo $r
