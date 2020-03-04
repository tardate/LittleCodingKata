#!/bin/sh
# starts InfluxDb in a Docker container

container_name=myinfluxdb
image_name=quay.io/influxdb/influxdb:2.0.0-beta

package_root="$(cd "$(dirname "$0")"; pwd)/${container_name}"
mkdir -p "${package_root}"


function shutdown() {
  echo "Stopping/removing any previous docker container.."
  docker stop ${container_name}
  docker rm ${container_name}
}


function startup() {
  echo "Starting ${demoserver} container with web access on port 9999.."
  docker run -d --name ${container_name} -p 9999:9999 \
    -v ${package_root}/data:/root/.influxdbv2 \
    ${image_name} --reporting-disabled
}


ACTION=${1:-help}

case ${ACTION} in

start)
  shutdown
  startup
  ;;

stop)
  shutdown
  ;;

shell)
  docker exec -it ${container_name} /bin/bash
  ;;

logs)
  docker logs ${container_name}
  ;;

*)
  echo "$0 start|stop|shell|logs"
  ;;

esac
