#!/usr/bin/env bash

IMAGE=mysql:8.0.35
eval "docker run -it --rm ${IMAGE} mysql $*"
