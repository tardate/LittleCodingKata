ARG FROM_REPO=docker/whalesay
ARG FROM_VERSION=latest

FROM ${FROM_REPO}:${FROM_VERSION}

RUN apt-get -y update && apt-get install -y fortunes
CMD /usr/games/fortune -a | cowsay
