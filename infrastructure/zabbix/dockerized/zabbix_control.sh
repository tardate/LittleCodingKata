#!/bin/sh
# starts zabbix in a Docker container

CONTAINER_NAME=dockerized_zabbix-app_1
AGENT_CONTAINER_NAME=dockerized_zabbix-agent_1

ACTION=${1:-help}

case ${ACTION} in

up|start)
  docker-compose up -d
  ;;

down|stop)
  docker-compose down
  ;;

shell)
  docker exec -it ${CONTAINER_NAME} sh
  ;;

agent-shell)
  docker exec -it ${AGENT_CONTAINER_NAME} sh
  ;;

logs)
  docker logs ${CONTAINER_NAME}
  ;;

volumes)
  docker volume ls | grep zapp
  ;;

*)
  echo "$0 start|stop|shell|logs|volumes"
  ;;

esac
