function rev() {
    len=${#1};
    rw="";
    for (( ii=len; ii; ii--)); do
        rw+=${1:ii-1:1};
    done;
};

mapfile -t w;

n=${w[0]};

for (( i=n; i; i--)); do { 
    k=$i;
    for (( j=i-1; j; j--)); do { 
        if [[ ${w[j]} < ${w[k]} ]]; then
            k=$j;
        fi;
    } done;
    x=${w[i]};
    w[i]=${w[k]};
    w[k]=$x;
} done;

s="";
c="";

for (( i=n; i; i--)); do {
    x=${w[i]};
    if [[ $x == "" ]]; then
        continue;
    fi;
    rev $x;
    j=i-1;
    for (( ; j; j--)); do { 
        if [[ $rw == ${w[j]} ]]; then {
            s+=$x;
            w[j]="";
            break;
        } fi;
    } done;
    if [[ j -eq 0 ]]; then
        if [[ $x == $rw ]]; then
            if [[ $c == "" ]]; then
                c=$x;
            elif [[ $x < $c ]]; then
                c=$x;
            fi;
        fi;
    fi;
} done;

rev $s;

echo -n $s;
echo -n $c;
echo $rw;
