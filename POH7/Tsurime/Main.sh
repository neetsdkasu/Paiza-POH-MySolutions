#!/bin/bash
# Try POH
# author: Leonardone @ NEETSDKASU
declare -i n;
read n;
s='';
while ((0 < n--)); do #
    s='Ann'$s;
done;
echo $s;
