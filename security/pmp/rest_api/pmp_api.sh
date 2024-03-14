#!/usr/bin/env bash
#

resource_name=${1:-help}
resource_id=${2}
sub_resource_name=${3}
sub_resource_id=${4}
sub_resource_operation=${5}

AUTHTOKEN=${AUTHTOKEN:-not-set}
PMP_URL=${PMP_URL:-https://localhost:7272}
if command -v jq &> /dev/null
then
  FORMATTER=${FORMATTER-jq '.'}
fi

function usage() {
  cat <<EOF

Demonstrate basic PMP REST API calls with curl

Usage:
  $0 resources
  $0 resources search <name-filter>
  $0 resources <resource-id>
  $0 resources <resource-id> account
  $0 resources <resource-id> account <account-id>
  $0 resources <resource-id> account <account-id> password

Environment settings:

  AUTHTOKEN : currently ${AUTHTOKEN} # PMP REST API authentication token
  PMP_URL   : currently ${PMP_URL} # PMP server url
  FORMATTER : currently ${FORMATTER} # response formatting utility

EOF
  exit
}

function do_get() {
  local url=$1
  local auth_header="AUTHTOKEN:${AUTHTOKEN}"
  local curl_opts=" --no-progress-meter -k "

  if [ -n "${FORMATTER}" ]
  then
    curl ${curl_opts} -H "${auth_header}" "${url}" | ${FORMATTER}
  else
    curl ${curl_opts} -H "${auth_header}" "${url}"
    echo
  fi
}

case ${resource_name} in
resources)
  operation=${2}
  operation_param=${3}
  case "${operation}" in
  search)
    qs="INPUT_DATA=%7B%22operation%22:%7B%22Details%22:%7B%22SEARCHCOLUMN%22:%22RESOURCENAME%22,%22SEARCHVALUE%22:%22${operation_param}%22,%22SEARCHTYPE%22:%22RESOURCE%22%7D%7D%7D"
    do_get "${PMP_URL}/restapi/json/v1/resources?${qs}"
    ;;
  *)
    do_get "${PMP_URL}/restapi/json/v1/resources"
    ;;
  esac
  ;;
resource)
  case "${sub_resource_name}" in
  account)
    if [ -n "${sub_resource_operation}" ]
    then
      do_get "${PMP_URL}/restapi/json/v1/resources/${parent_id}/accounts/${sub_resource_id}/${sub_resource_operation}"
    else
      do_get "${PMP_URL}/restapi/json/v1/resources/${parent_id}/accounts/${sub_resource_id}"
    fi
    ;;
  *)
    do_get "${PMP_URL}/restapi/json/v1/resources/${parent_id}/accounts"
    ;;
  esac
  ;;
audit)
  do_get "${PMP_URL}/restapi/json/v1/audit?AUDITTYPE=Resource&STARTINDEX=1&LIMIT=2&DURATION=YESTERDAY"
  ;;
*)
  usage
  ;;
esac
