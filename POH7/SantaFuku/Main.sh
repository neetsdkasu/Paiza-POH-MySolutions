#!/bin/bash
# Try POH
# author: Leonardone @ NEETSDKASU
declare -i x y z n d a xc yc t i xmin ymin;
declare -ai xs ys;
read x y z n;
xmin=$x;
ymin=$y;
function abs() { let $(($1=($1 < 0) ? -$1 : $1 )); };
function min() { let $(($1=($1 < $2) ? $1 : $2)); };
xc=0;
yc=0;
for ((;n;n--)); do { #
    read d a;
    if (( d == 0 )); then { #
        min xmin $a;
        t=$(( x - a ));
        abs t;
        min xmin $t;
        for ((i=0;i<xc;i++)); do { #
            t=$(( xs[i] - a ));
            abs t;
            min xmin $t;
        }; done;
        xs[xc]=$a;
        let xc++;
    }; else { #
        min ymin $a;
        t=$(( y - a ));
        abs t;
        min ymin $t;
        for ((i=0;i<yc;i++)); do { #
            t=$(( ys[i] - a ));
            abs t;
            min ymin $t;
        }; done;
        ys[yc]=$a;
        ((yc++));
    }; fi;
}; done;
echo $(( xmin * ymin * z ));
