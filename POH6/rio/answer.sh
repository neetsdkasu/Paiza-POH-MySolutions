
typeset -a lines;
typeset -i n i j task_ size_ wa wb ca cb gcd wca wcb ra rb;
typeset x;

function split() {
    task_=$1;
    size_=$2;
};

function calcGCD() {
    if [[ $1 -eq 0 ]]; then {
        gcd=$2;
        return;
    }; fi;
    if [[ $2 -eq 0 ]]; then {
        gcd=$1;
        return;
    }; fi;
    if [[ $1 > $2 ]]; then {
        calcGCD $(($1 % $2)) $2;
    }; else {
        calcGCD $(($2 % $1)) $1;
    }; fi;
};

function addBS() {
    if [[ $2 -eq $4 ]]; then {
        ra=$(($1 + $3));
        rb=$2;
    }; else {
        ra=$(($1 * $4 + $3 * $2));
        rb=$(($2 * $4));
    }; fi;
    calcGCD $ra $rb;
    ra=$(($ra / $gcd));
    rb=$(($rb / $gcd));
};

function subBS() {
    if [[ $2 -eq $4 ]]; then {
        ra=$(($1 - $3));
        rb=$2;
    }; else {
        ra=$(($1 * $4 - $3 * $2));
        rb=$(($2 * $4));
    }; fi;
    calcGCD $ra $rb;
    ra=$(($ra / $gcd));
    rb=$(($rb / $gcd));
};

mapfile -t lines;

n=${lines[0]};

wa=0
wb=1
ca=0
cb=1


for (( i=$n; $i; i--)); do {
    split ${lines[$n-$i+1]};
    #echo $task_
    #echo $size_
    case $task_ in
    1 ) {
            addBS $wa $wb $size_ 1;
            wa=$ra;
            wb=$rb;
        } ;;&
    2 ) {
            addBS $ca $cb $size_ 1;
            ca=$ra;
            cb=$rb;
        } ;;&
    3 ) {
            addBS $wa $wb $ca $cb;
            wca=$ra;
            wcb=$rb;
        } ;;
    esac;
}; done;

echo $wa
echo $ca
