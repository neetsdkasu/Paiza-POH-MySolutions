#!/bin/bash

typeset -iA m e;
typeset -a w z;
typeset -i n wn v i j k u;
typeset x c s y rw;

function rev() {
    local -i len=${#1};
    local -i ii;
    rw="";
    for (( ii=len; ii; ii--)); do
        rw+=${1:ii-1:1};
    done;
};

mapfile -t z;

n=${z[0]};
c="";
s="";

for (( i=n; i; i--)); do {
    x=${z[i]};
    m[$x]+=1;
}; done;

for x in ${!m[*]}; do {
    v=${m[$x]};
    if [[ v -eq 0 ]]; then
        continue;
    fi;
    rev $x;
    if [[ ${m[$rw]} -gt 0 ]]; then {
        u=${m[$rw]};
        if [[ v -gt u ]]; then
            v=$u;
        fi;
        m[$rw]=0;
        if [[ $x < $rw ]]; then
            e[$x]=$v;
        elif [[ $x > $rw ]]; then
            e[$rw]=$v;
        else {
            u=$((v & 1));
            if [[ u -eq 1 ]]; then
                if [[ $c == "" || $c > $x ]]; then
                    c=$x;
                fi;
            fi;
            u=$((v >> 1));
            e[$x]=$u;
        }; fi;
    }; fi;
}; done;

wn=0;
for x in ${!e[*]}; do {
    w[wn]=$x;
    wn+=1;
}; done;

for (( i=$wn; i; i--)); do {
    k=$i;
    for (( j=$i-1; j; j--)); do {
        if [[ ${w[j-1]} < ${w[k-1]} ]]; then
            k=$j;
        fi;
    }; done;
    x=${w[i-1]};
    w[i-1]=${w[k-1]};
    w[k-1]=$x;
}; done;

for (( i=$wn; i; i--)); do {
    x=${w[i-1]};
    v=${e[$x]};
    for (( j=$v; j; j--)); do {
        s+=$x;
    }; done;
}; done;

rev $s;

echo -n $s;
echo -n $c;
echo $rw;
