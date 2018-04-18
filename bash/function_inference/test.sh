#!/bin/bash
#


function usage() {
  local name=$1
  if [ "${name}" != "" ]
  then
    echo "Sorry, we don't have a function for '${name}'"
    exit 1
  fi
  cat <<EOF

Calls a function matching the first parameter

Usage:
  $0 name

Where:
  name = apples  ... calls function 'run_apples'
  name = oranges ... calls function 'run_oranges'
  etc

EOF
}


# A couple of functions that are available to be called..
#


function run_apples() {
  echo "apples!"
}


function run_oranges() {
  echo "oranges!"
}


# Tests whether the function name is valid.
# This could be done inline, but making it a function itself assists reuse.
function is_function() {
  local name=$1
  type  -t "${name}" 2>/dev/null | grep -q 'function'
}


name=$1
function_name=run_${name}

# if is_function $function_name
if type  -t "${function_name}" 2>/dev/null | grep -q 'function'
then
  echo "# calling the function ${function_name} now we know it exists.."
  $function_name
else
  usage $name
fi
