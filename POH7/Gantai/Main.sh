#!/bin/bash
# Try POH
# author: Leonardone @ NEETSDKASU
declare -i n m1 m2 i t c;
declare -ia x y h r;
read n;
read m1;
read -a x;
read m2;
read -a y;
for t in ${x[*]}; do h[t]=1; done;
for t in ${y[*]}; do if (( h[t] != 1 )); then r[t]=$t; fi; done;
if (( ${#r[*]} > 0 )); then echo ${r[*]}; else echo 'None'; fi;
