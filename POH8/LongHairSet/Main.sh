#!/bin/bash
# Try POH 
#author: Leonardone @ NEETSDKASU
typeset -i a #
read a #
if (($a % 7)); then #
    echo 'unlucky' #
else #
    echo 'lucky' #
fi #
