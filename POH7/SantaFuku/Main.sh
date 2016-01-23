#!/bin/bash
# Try POH
# author: Leonardone @ NEETSDKASU
declare -i x y z n d a xc yc t i j k xmin ymin;
declare -ai xs ys;
read x y z n;
xmin=$x;
ymin=$y;
function min() { let $(($1=($1 < $2) ? $1 : $2)); };
xs[0]=0;
xs[1]=$x;
ys[0]=0;
ys[1]=$y;
xc=2;
yc=2;
for ((;n;n--)); do #
    read d a;
    if (( d == 0 )); then #
        xs[xc]=$a;
        let xc++;
    else #
        ys[yc]=$a;
        ((yc++));
    fi;
done;
for ((i=0;((i<xc));i++)); do #
    j=$i;
    t=${xs[$j]};
    for ((k=i+1;((k<xc));k++)); do #
        if ((t < xs[k])); then #
            j=$k;
            t=${xs[$k]};
        fi;
    done;
    xs[j]=${xs[$i]};
    xs[i]=$t;
done;
for ((i=1;((i<xc));i++)); do #
    min xmin $((xs[i-1] - xs[i]));
done;
for ((i=0;((i<yc));i++)); do #
    j=$i;
    t=${ys[$j]};
    for ((k=i+1;((k<yc));k++)); do #
        if ((t < ys[k])); then #
            j=$k;
            t=${ys[$k]};
        fi;
    done;
    ys[j]=${ys[$i]};
    ys[i]=$t;
done;
for ((i=1;((i<yc));i++)); do #
    min ymin $((ys[i-1] - ys[i]));
done;
echo $(( xmin * ymin * z ));
