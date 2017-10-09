#!/bin/bash

echo
echo "This script demonstrates parsing an environment variable"
echo "Uses an invented encoding:"
echo " - major parts delimited by /"
echo " - minor parts delimited by :"
echo


# parse major and minor parts with IFS scan
function parse_with_ifs() {
  local value=$1
  local old_IFS="$IFS"
  local major_parts
  local major_part
  local minor_parts
  local minor_part

  echo "parse_with_ifs: ${value}"

  IFS=/ major_parts=( $value )

  echo "Major parts count: ${#major_parts[@]}"

  for major_part in ${major_parts[@]}
  do
    echo "loop with major_part==${major_part}"
    IFS=: minor_parts=( $major_part )
    for minor_part in ${minor_parts[@]}
    do
      echo "  loop with minor_part==${minor_part}"
    done
  done
  echo

  IFS="${old_IFS}"
}


# parse major with IFS and minor parts with parameter substitution
function parse_with_ifs_and_parameter_substitution() {
  local value=$1
  local old_IFS="$IFS"
  local major_parts

  echo "parse_with_ifs_and_parameter_substitution: ${value}"

  IFS=/ major_parts=( $value )
  IFS="${old_IFS}"

  echo "Major parts count: ${#major_parts[@]}"

  for major_part in ${major_parts[@]}
  do
    echo "loop with major_part==${major_part}"
    first_part=${major_part%:*}
    second_part=${major_part#*:}
    echo "  first_part==${first_part}"
    echo "  second_part==${second_part}"

  done
  echo
}


parse_with_ifs "part1:part2"
parse_with_ifs "part1:part2/part3:part4/part5:part6"
parse_with_ifs_and_parameter_substitution "part1:part2"
parse_with_ifs_and_parameter_substitution "part1:part2/part3:part4/part5:part6"

