#!/bin/bash

# get the first argument, or default to 'help'
val=${1:-help}

case "${val}" in
[0-6]*)
  pattern="under 7*"
  ;;
[7-8]*)
  pattern="like 7* or 8*"
  ;;
9*)
  pattern="like 9*"
  ;;
*hand)
  pattern="like *hand"
  ;;
abc)
  pattern="abc"
  ;;
def)
  pattern="def"
  ;;
def)
  pattern="def (duplicate)"
  ;;
a | b)
  pattern="a or b"
  ;;
*)
  pattern="(default)"
  ;;
esac

echo "${val} is: ${pattern}"
