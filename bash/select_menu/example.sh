#!/bin/bash

echo
echo "This script demonstrates the basic select menu."
echo

old_PS3=$PS3
PS3="select> "

options="apple orange quit"

select OPTION in $options
do
  echo "You picked $OPTION ($REPLY)"

  case $OPTION in
  quit)
    break
    ;;
  esac

done

# be super-safe: reinstate the original PS3 prompt
PS3=$old_PS3
