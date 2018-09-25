#!/bin/bash

val=${1}

case "${val}" in
abc)
  pattern="defined option: abc"
  ;;
"")
  pattern="blank option"
  ;;
*)
  pattern="(default)"
  ;;
esac

echo "${val} is: ${pattern}"
