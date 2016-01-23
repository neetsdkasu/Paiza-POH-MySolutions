#!/bin/bash
# Try POH
# author: Leonardone @ NEETSDKASU
declare -i c1 p1 c2 p2;
read c1 p1;
read c2 p2;
if (( c1 * p2 > c2 * p1 )); then echo '1'; else echo '2'; fi;
