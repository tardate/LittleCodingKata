#!/bin/bash
#
# Simple demonstration of the while command
#
n1=0
n2=${1:-5}
style=${2:-"default"}

case $style in
  "c-style-increment")
    echo "loop while -le ${n2} with c-style increment"
    while [ $n1 -le $n2 ]
    do
      echo "n1==${n1}"
      ((n1++))
    done
    ;;
  "c-style-inline-decrement")
    n1=${n2}
    n2=0
    echo "loop from ${n1} to ${n2} with c-style inline decrement"
    while ((n1--))
    do
      echo "n1==${n1}"
    done
    ;;
  *)
    echo "loop while -le ${n2}"
    while [ $n1 -le $n2 ]
    do
      echo "n1==${n1}"
      n1=$(($n1+1))
    done
    ;;
esac


echo "finished now n1==${n1}"
