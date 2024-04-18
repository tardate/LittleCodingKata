#!/usr/bin/env bash

infile=words.txt

echo -e "\n# all these examples are given ${infile} as input:"
cat ${infile}

echo -e "\n# example 1: by default, pass all input lines/tokens as params to the default command (echo)"
cat ${infile} | xargs

echo -e "\n# example 1b: adding --verbose echoes the command that xargs will run"
cat ${infile} | xargs --verbose

echo -e "\n# example 1c: -n limits the number of tokens grouped for each invovation of the command. In this case -n 2:"
cat ${infile} | xargs --verbose -n 2

echo -e "\n# example 1d: -L limits the number of lines used for each invovation of the command. In this case -L 2:"
cat ${infile} | xargs --verbose -L 2

echo -e "\n# example 2: -I replaces occurrences of the specified pattern in the command arguments with lines read"
cat ${infile} | xargs -I here echo "I got a word (here) to work with"

echo -e "\n# example 2b: combining -n 1 with -I causes one commend to be run per token from the input"
cat ${infile} | xargs -n 1 -I here echo "I got a word (here) to work with"

echo -e "\n# example 3: xargs is an alternative to using a script to explicitly iterate over items e.g. with a for loop"
for word in $(cat ${infile})
do
  echo "for loop: next item I got is ${word}"
done
