ARG FROM_REPO=ubuntu
ARG FROM_VERSION=22.04
FROM ${FROM_REPO}:${FROM_VERSION}

RUN apt -y update && apt -y install cowsay

ENTRYPOINT ["/usr/games/cowsay"]
