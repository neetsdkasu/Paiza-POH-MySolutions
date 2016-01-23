#!/bin/bash
# Try POH
# author: Leonardone @ NEETSDKASU
declare -i x y z n d a i k xmin ymin;
declare -ai xs ys;
read x y z n;
xmin=$x;
ymin=$y;
xs[x]=x;
ys[y]=y;
for ((;n;n--)) do #
    read d a;
    if (( d == 0 )); then #
        xs[a]=a;
    else #
        ys[a]=a;
    fi;
done;
k=0;
for i in ${xs[@]}; do #
    if (( (i - k) < xmin )); then #
        xmin=$((i - k));
    fi;
    k=$i;
done;
k=0;
for i in ${ys[@]}; do #
    if (( (i - k) < ymin )); then #
        ymin=$((i - k));
    fi;
    k=$i;
done;
echo $(( xmin * ymin * z ));
