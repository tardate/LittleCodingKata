#!/usr/bin/env bash

dist_file=ManageEngine_PMP_64bit.bin
dist_url="https://download.manageengine.com/products/passwordmanagerpro/8621641/${dist_file}"
IMAGE=lck/pmp

if [ -f "${dist_file}" ]
then
  echo "Using existing ${dist_file} download"
else
  curl -O -k ${dist_url}
fi

docker-compose build
