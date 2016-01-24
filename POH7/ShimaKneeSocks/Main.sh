#!/bin/bash
# Try POH
# author: Leonardone @ NEETSDKASU
declare -i n m i;
read n;
read m;
s='';
for ((i=0;i<m;i++)); do { # 
    if (( (i / n) % 2 )); then { #
        s=$s'W';
    }; else { #
        s=$s'R';
    }; fi;
}; done;
echo $s;
