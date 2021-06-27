# explicitly use a base image specific for the target platform
FROM --platform=$TARGETPLATFORM golang:alpine AS builder
RUN apk add build-base
WORKDIR /home

# log the build/target env details
ARG TARGETPLATFORM
ARG BUILDPLATFORM
RUN echo "I am running on $BUILDPLATFORM, building for $TARGETPLATFORM" > build.log

# build a simple c program that will be our diagnostic
COPY hello.c .
RUN gcc "-DARCH=\"`uname -a`\"" hello.c -o hello
ENTRYPOINT ["./hello"]
