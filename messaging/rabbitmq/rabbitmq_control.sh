#!/usr/bin/env bash
# RabbitMQ control

ACTION=${1:-help}

case ${ACTION} in

start)
  CONF_ENV_FILE="/opt/homebrew/etc/rabbitmq/rabbitmq-env.conf" /opt/homebrew/opt/rabbitmq/sbin/rabbitmq-server
  /opt/homebrew/sbin/rabbitmqctl enable_feature_flag all
  ;;

up)  
  docker-compose up $2
  ;;

down)  
  docker-compose down
  ;;

*)
  echo "$0 start"
  ;;

esac
