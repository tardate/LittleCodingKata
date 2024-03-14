# ubuntu

Using the official ubuntu docker images.

## Notes

### Running the Latest Image

The ubuntu:latest tag points to the "latest LTS"

    docker pull ubuntu:latest

If there are no instances of the image running, start a new one and execute directly to shell:

    $ docker run --rm -it --entrypoint bash ubuntu:latest
    root@652b3942f677:/# uname -a
    Linux 652b3942f677 6.5.11-linuxkit #1 SMP PREEMPT Wed Dec  6 17:08:31 UTC 2023 aarch64 aarch64 aarch64 GNU/Linux
    root@652b3942f677:/# cat /etc/lsb-release
    DISTRIB_ID=Ubuntu
    DISTRIB_RELEASE=22.04
    DISTRIB_CODENAME=jammy
    DISTRIB_DESCRIPTION="Ubuntu 22.04.4 LTS"

## Building a Docker Image Based on Ubuntu

The [Dockerfile](./Dockerfile) is a simple example of an image bas on the `ubuntu:22.04` image.

It updates the catalog and installs the cowsay program.

Building the image:

    docker build -t lck/ubuntu .

Running the image:

    docker run --rm lck/ubuntu hi
    ____
    < hi >
    ----
            \   ^__^
            \  (oo)\_______
                (__)\       )\/\
                    ||----w |
                    ||     ||

Cleaning up the image:

    docker rmi lck/ubuntu

## Credits and References

* [ubuntu Docker Official Image](https://hub.docker.com/_/ubuntu)
* [What are some good ASCII art generators?](https://askubuntu.com/questions/16837/what-are-some-good-ascii-art-generators)
