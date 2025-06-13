#!/usr/bin/env bash

VERSION=1.0.0
IMAGE_NAME="tardate/echo-tools"
OP=${1:-build}

set -e

case ${OP} in
  build)
    echo "Building Docker image ${IMAGE_NAME}:${VERSION}"
    docker build -t ${IMAGE_NAME}:${VERSION} .
    docker tag ${IMAGE_NAME}:${VERSION} ${IMAGE_NAME}:latest
    docker image ls ${IMAGE_NAME}
    ;;
  push)
    echo "Pushing Docker image ${IMAGE_NAME}:${VERSION}"
    docker push ${IMAGE_NAME}:${VERSION}
    docker push ${IMAGE_NAME}:latest
    ;;
  *)
    echo "Unknown command: ${OP}"
    exit 1
    ;;
esac
