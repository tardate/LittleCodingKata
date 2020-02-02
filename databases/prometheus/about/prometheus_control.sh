#!/bin/sh
# starts prometheus in a Docker container

CONTAINER_NAME=demoserver
IMAGE_NAME=prom/prometheus
PACKAGE_ROOT="$(cd "$(dirname "$0")"; pwd)/${CONTAINER_NAME}"

function shutdown() {
  echo "Stopping/removing any previous docker container.."
  docker stop ${CONTAINER_NAME}
  docker rm ${CONTAINER_NAME}
}

function startup() {
  echo "Starting ${CONTAINER_NAME} prometheus container with web access on port 9090.."
  docker run -d -p 9090:9090 --name=${CONTAINER_NAME} \
    -v ${PACKAGE_ROOT}/demo_targets.json:/etc/prometheus/demo_targets.json:ro \
    -v ${PACKAGE_ROOT}/prometheus.yml:/etc/prometheus/prometheus.yml:ro \
    ${IMAGE_NAME}
}


ACTION=${1:-start}

case ${ACTION} in

start)
  shutdown
  startup
  ;;

stop)
  shutdown
  ;;

shell)
  docker exec -it ${CONTAINER_NAME} sh
  ;;

logs)
  docker logs ${CONTAINER_NAME}
  ;;

*)
  echo "$0 start|stop|shell|logs"
  ;;

esac
