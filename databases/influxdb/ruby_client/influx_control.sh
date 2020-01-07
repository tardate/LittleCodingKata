#!/bin/sh
# helpers for running InfluxDb 1.7.9 in a Docker container

container_name=myinfluxdb17
image_name=influxdb:1.7.9

package_root="$(cd "$(dirname "$0")"; pwd)/${container_name}"
mkdir -p "${package_root}"


function shutdown() {
  echo "Stopping/removing any previous docker container.."
  docker stop ${container_name}
  docker rm ${container_name}
}


function startup() {
  echo "Starting ${demoserver} container with API access on port 8086 and persistent local storage.."
  docker run -d --name ${container_name} -p 8086:8086 \
    -e INFLUXDB_REPORTING_DISABLED=true \
    -v ${package_root}/data:/var/lib/influxdb \
    ${image_name}

  # to use external config file, add:
  # -v ${package_root}/influxdb.conf:/etc/influxdb/influxdb.conf:ro \
  # ${image_name} -config /etc/influxdb/influxdb.conf
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

cli)
  docker exec -it ${container_name} influx
  ;;

shell)
  docker exec -it ${container_name} /bin/bash
  ;;

config)
  docker run --rm ${image_name} influxd config > ${package_root}/influxdb.conf
  ;;

logs)
  docker logs ${container_name}
  ;;

*)
  echo "$0 config # generates config"
  echo "$0 start  # starts or restarts container"
  echo "$0 stop   # stops container"
  echo "$0 cli    # attaches to cli for running container"
  echo "$0 shell  # attaches to shell for running container"
  echo "$0 logs   # tail logs for running container"
  ;;

esac
