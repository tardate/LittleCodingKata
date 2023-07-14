#!/bin/bash
function usage() {
  cat <<EOF

Usage:
  $0 ?
  $0 account_info
  $0 currencies
  $0 (from_currency) to (target_currency)


  XE_API_ID  = ${XE_API_ID}
  XE_API_KEY = ${XE_API_KEY}

e.g.

  $0 account_info

EOF
  exit
}

function api_get() {
  local url=${1}
  curl -u "${AUTH_PARAMS}" "${url}" | jq
  echo
}


BASE_URL="https://xecdapi.xe.com/v1"
AUTH_PARAMS="${XE_API_ID}:${XE_API_KEY}"

p1=${1}
p2=${2}
p3=${3}
if [ "${p2}" == "to" ] ; then
  method="convert_to"
else
  method=${p1}
fi

case ${method} in

account_info)
  api_get "${BASE_URL}/account_info/"
  ;;

currencies)
  api_get "${BASE_URL}/currencies/"
  ;;

convert_to)
  api_get "${BASE_URL}/convert_to/?from=${p1}&to=${p3}"
  ;;

*)
  usage
  ;;
esac
