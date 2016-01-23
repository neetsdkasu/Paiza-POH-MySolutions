#!/bin/bash
# Try POH
# author: Leonardone @ NEETSDKASU
declare -i n;
declare -a s;
read n;
mapfile -t -n $n s;
a=${s[*]};
echo ${a// /_};
