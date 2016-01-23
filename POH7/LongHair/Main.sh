#!/bin/bash
# Try POH
# author: Leonardone @ NEETSDKASU
declare -i c;
declare -a p;
mapfile -t -n 5 p;
for s in ${p[*]}; do if [[ 'yes' == $s ]]; then let c++; fi; done;
if ((c > 2)); then echo 'yes'; else echo 'no'; fi;
