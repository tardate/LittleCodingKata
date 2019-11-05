#!/bin/bash

url="http://0.0.0.0:4567/"
echo "Sending some traffic to ${url} [ hit CTRL+C to stop]"
for (( ; ; ))
do
  echo "."
  curl ${url} > /dev/null 2>&1
  sleep 1
done
