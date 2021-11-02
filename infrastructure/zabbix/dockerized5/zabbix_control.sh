#!/bin/sh
# starts zabbix 5 in a Docker container

DB_CONTAINER_NAME=dockerized5_mysql-server_1
SERVER_CONTAINER_NAME=dockerized5_zabbix-server_1
AGENT_CONTAINER_NAME=dockerized5_zabbix-agent_1
WEB_CONTAINER_NAME=dockerized5_zabbix-web-apache-mysql_1


ACTION=${1:-help}

case ${2:-server} in
agent)
  TARGET_CONTAINER=${AGENT_CONTAINER_NAME}
  ;;
web)
  TARGET_CONTAINER=${WEB_CONTAINER_NAME}
  ;;
db)
  TARGET_CONTAINER=${DB_CONTAINER_NAME}
  ;;
*)
  TARGET_CONTAINER=${SERVER_CONTAINER_NAME}
  ;;
esac

case ${ACTION} in

up|start)
  docker-compose up -d
  ;;

down|stop)
  docker-compose down
  ;;

shell)
  docker exec -it ${TARGET_CONTAINER} sh
  ;;

logs)
  docker logs ${TARGET_CONTAINER}
  ;;

volumes)
  docker volume ls | grep zabbix5
  ;;

volumerm)
  docker volume rm dockerized5_zabbix5-db
  ;;

*)
  echo "$0 start|stop|shell|logs|volumes|volumerm"
  ;;

esac
