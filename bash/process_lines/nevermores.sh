#!/bin/bash

source_file=the_raven.txt

echo
echo "Using for..in with default IFS, we get words not lines:"

for line in $(head -2 ${source_file})
do
  echo "> ${line}"
done


echo
echo "Reset the IFS for newline, then for..in gives us lines:"

# Save the current internal field separator
OLDIFS="$IFS"

# Set the field separator to Line Feed: octal 012, hex 0A, aka \n
IFS=$'\012'

for line in $(cat ${source_file} | grep -i nevermore | sed -e 's/^[[:space:]]*//' )
do
  echo "> ${line}"
done

# Restore the original field separator
IFS="$OLDIFS"

echo
