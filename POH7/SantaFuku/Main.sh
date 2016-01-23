#!/bin/bash
# Try POH
# author: Leonardone @ NEETSDKASU
declare -i x y z n d a t i j k xmin ymin;
declare -ai xs ys;
read x y z n;
xmin=$x;
ymin=$y;
for ((i=101;i;i--)); do #
    xs[i]=0;
    ys[i]=0;
done;
xs[0]=1;
xs[x]=1;
ys[0]=1;
ys[y]=1;
for ((;n;n--)) do #
    read d a;
    if (( d == 0 )); then #
        xs[a]=1;
    else #
        ys[a]=1;
    fi;
done;
k=0;
for ((i=1;i<101;i++)); do #
    if ((xs[i])); then #
        t=$((i - k));
        if ((t < xmin)); then #
            xmin=$t;
        fi;
        k=$i;
    fi;
done;
k=0;
for ((i=1;i<101;i++)); do #
    if ((ys[i])); then #
        t=$((i - k));
        if ((t < ymin)); then #
            ymin=$t;
        fi;
        k=$i;
    fi;
done;
echo $(( xmin * ymin * z ));
