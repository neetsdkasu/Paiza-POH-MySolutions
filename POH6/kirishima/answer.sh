#!/bin/bash

typeset -a lines;
typeset -ia t f;
typeset -i n m i d j;
typeset x r;

mapfile -t lines;

n=${lines[0]};
m=${lines[2]};

i=0;
for x in ${lines[1]}; do {
    t[$i]=$x;
    i+=1;
}; done;

for (( i=$m; $i; i--)); do {
    d=${lines[$m-$i+3]};
    for (( j=$n; $j; j--)); do {
        f[$n-$j]=0;
    }; done;
    r='No';
    for ((;;)); do {
        if [[ $d -lt 1 || $d -ge $n ]]; then {
            break;
        }; fi;
        if [[ $d -eq $(($n - 1)) ]]; then {
            r='Yes';
            break;
        }; fi;
        if [[ ${t[$d]} -eq 0 ]]; then {
            break;
        }; fi;
        if [[ ${f[$d]} -eq 1 ]]; then {
            break;
        }; fi;
        f[$d]=1;
        d+=${t[$d]};
    }; done;
    echo $r;
}; done;

