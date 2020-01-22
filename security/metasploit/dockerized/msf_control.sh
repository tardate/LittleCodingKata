#!/bin/sh
# starts metasploit framework in a Docker container

CONTAINER_NAME=mymsf
IMAGE_NAME=metasploitframework/metasploit-framework
WORKING_ROOT="$(cd "$(dirname "$0")"; pwd)/${CONTAINER_NAME}"

function shutdown() {
  echo "Stopping/removing any previous docker container.."
  docker stop ${CONTAINER_NAME}
  docker rm ${CONTAINER_NAME}
  docker-compose down
}

ACTION=${1:-help}

case ${ACTION} in

solo)
  echo "Starting ${CONTAINER_NAME} container.."
  docker run --rm -it --name=${CONTAINER_NAME} ${IMAGE_NAME}
  ;;

ms)
  mkdir -p ${WORKING_ROOT}
  docker-compose run --rm --service-ports -e MSF_UID=$(id -u) -e MSF_GID=$(id -g) ms
  ;;

msfvenom)
  mkdir -p ${WORKING_ROOT}
  docker-compose run --rm --no-deps -e MSF_UID=$(id -u) -e MSF_GID=$(id -g) ms ./msfvenom
  ;;

stop)
  shutdown
  ;;

*)
  echo "$0 solo|ms|msfvenom|stop"
  ;;

esac
