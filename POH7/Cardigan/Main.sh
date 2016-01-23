#!/bin/bash
# Try POH
# author: Leonardone @ NEETSDKASU
declare -i n r;
read n;
r=1;
for ((;n;n--)); do let r*=n; done;
echo $r;
