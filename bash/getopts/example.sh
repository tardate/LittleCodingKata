#!/bin/bash
function usage() {
  cat <<EOF

Usage

  $0 -p value # set "p" to value
  $0 -v       # set "v" true
  $0 -h       # this message

EOF
  exit 1
}

if [ "${1}" == "magic" ]
then
  echo "magic: detected special argument"
  shift
fi

while getopts "hp:v" opt
do
  case $opt in
  p)
    p=$OPTARG
    ;;
  v)
    v=true
    ;;
  h)
    usage
    ;;
  \?)
    echo "(handling an error)"
    usage
    ;;
  esac
done

echo "got p: $p"
echo "got v: $v"
