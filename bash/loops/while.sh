#!/bin/bash
#
# Simple demonstration of the while command
#
n1=0
n2=${1:-5}
while [ $n1 -le $n2 ]
do
  echo "loop with n1==${n1}"
  n1=$(($n1+1))
done

echo "finished now n1==${n1}"
