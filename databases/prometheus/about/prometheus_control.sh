#!/bin/sh
# starts prometheus in a Docker container

container_name=demoserver

package_root="$(cd "$(dirname "$0")"; pwd)/${container_name}"

function shutdown() {
  echo "Stopping/removing any previous docker container.."
  docker stop ${container_name}
  docker rm ${container_name}
}

function startup() {
  echo "Starting ${demoserver} prometheus container with web access on port 9090.."
  docker run -d -p 9090:9090 --name=${container_name} \
    -v ${package_root}/demo_targets.json:/etc/prometheus/demo_targets.json:ro \
    -v ${package_root}/prometheus.yml:/etc/prometheus/prometheus.yml:ro \
    prom/prometheus
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
  docker exec -it ${container_name} sh
  ;;

logs)
  docker logs ${container_name}
  ;;

*)
  echo "$0 start|stop|shell|logs"
  ;;

esac
