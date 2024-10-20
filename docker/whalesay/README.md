# #178

Building and testing the whalesay docker demo

## Notes

The [whalesay](https://hub.docker.com/r/docker/whalesay/) example was created for docker training course.

### Testing whalesay

<https://hub.docker.com/r/docker/whalesay/>

    $ docker run docker/whalesay cowsay boo
    Unable to find image 'docker/whalesay:latest' locally
    latest: Pulling from docker/whalesay
    Image docker.io/docker/whalesay:latest uses outdated schema1 manifest format. Please upgrade to a schema2 image for better future compatibility. More information at https://docs.docker.com/registry/spec/deprecated-schema-v1/
    e190868d63f8: Already exists
    909cd34c6fd7: Already exists
    0b9bfabab7c1: Already exists
    a3ed95caeb02: Already exists
    00bf65475aba: Already exists
    c57b6bcc83e3: Already exists
    8978f6879e2f: Already exists
    8eed3712d2cf: Already exists
    Digest: sha256:178598e51a26abbc958b8a2e48825c90bc22e641de3d31e18aaf55f3258ba93b
    Status: Downloaded newer image for docker/whalesay:latest
    _____
    < boo >
    -----
        \
        \
          \
                      ##        .
                ## ## ##       ==
              ## ## ## ##      ===
          /""""""""""""""""___/ ===
    ~~~ {~~ ~~~~ ~~~ ~~~~ ~~ ~ /  ===- ~~~
          \______ o          __/
          \    \        __/
              \____\______/

this has pulled the image locally and left a stopped container after execution:

    $ docker ps -a
    CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS                      PORTS               NAMES
    910b35e59bc1        docker/whalesay     "cowsay boo"        34 seconds ago      Exited (0) 33 seconds ago                       peaceful_borg

    $ docker images docker/whalesay
    REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE
    docker/whalesay     latest              6b362a9f73eb        5 years ago         247MB

cleaning up the contain and images

    $ docker rm peaceful_borg
    peaceful_borg

    $ docker rmi docker/whalesay
    Untagged: docker/whalesay:latest
    Untagged: docker/whalesay@sha256:178598e51a26abbc958b8a2e48825c90bc22e641de3d31e18aaf55f3258ba93b
    Deleted: sha256:6b362a9f73eb8c33b48c95f4fcce1b6637fc25646728cf7fb0679b2da273c3f4

The `--rm` (remove) flag can be used to automatically remove the container when it has exited:

    $ docker run --rm docker/whalesay cowsay moo
    _____
    < moo >
    -----
        \
        \
          \
                      ##        .
                ## ## ##       ==
              ## ## ## ##      ===
          /""""""""""""""""___/ ===
    ~~~ {~~ ~~~~ ~~~ ~~~~ ~~ ~ /  ===- ~~~
          \______ o          __/
          \    \        __/
              \____\______/

    $ docker ps -a
    CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS              PORTS               NAMES
    $

### Building a Derivative Image

The [Dockerfile](./Dockerfile) describes an image that layers a new command on the basic whalesay image

    ARG FROM_REPO=docker/whalesay
    ARG FROM_VERSION=latest

    FROM ${FROM_REPO}:${FROM_VERSION}

    RUN apt-get -y update && apt-get install -y fortunes
    CMD /usr/games/fortune -a | cowsay

Building a new image:

    docker build -t lck/whalesay .

Running it:

    $ docker run --rm lck/whalesay
    ________________________________________
    / History, n.:                           \
    |                                        |
    | Papa Hegel he say that all we learn    |
    | from history is that we                |
    |                                        |
    | learn nothing from history. I know     |
    | people who can't even learn from       |
    |                                        |
    | what happened this morning. Hegel must |
    | have been taking the long view.        |
    |                                        |
    | -- Chad C. Mulligan, "The Hipcrime     |
    \ Vocab"                                 /
    ----------------------------------------
        \
        \
          \
                        ##        .
                  ## ## ##       ==
              ## ## ## ##      ===
          /""""""""""""""""___/ ===
      ~~~ {~~ ~~~~ ~~~ ~~~~ ~~ ~ /  ===- ~~~
          \______ o          __/
            \    \        __/
              \____\______/

Cleaning up:

    docker rmi lck/whalesay

## Credits and References

* [whalesay](https://hub.docker.com/r/docker/whalesay/) - docker hub
* [whalesay](https://github.com/docker/whalesay) - github
* [](https://docs.dockstore.org/en/feature-bcc-2020-notes/docker_instructions.html)
