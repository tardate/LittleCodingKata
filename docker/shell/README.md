# Docker Shell

How to get a bash shell in a docker instance

## Notes

Assuming we're running a *nix OS in docker.. how to get a shell inside the container?

I'm using the [official nginx image](https://hub.docker.com/_/nginx) for testing...

### Shell in a New Container

If there are no instances of the image running, start a new one and execute directly to shell:

    $ docker run --rm -it --entrypoint bash nginx
    root@32cf098b15ab:/# uname -a
    Linux 32cf098b15ab 4.19.76-linuxkit #1 SMP Tue May 26 11:42:35 UTC 2020 x86_64 GNU/Linux
    exit

### Shell in an Existing Container

Start a container:

    $ docker run --name testing -d nginx
    ac7d587931708be4092ed876c7a0804d141b2d6d2db0de08a40cded0038ae5e8

Then exec the shell addressing the instance by name:

    $ docker exec -it testing /bin/bash
    root@ac7d58793170:/# uname -a
    Linux ac7d58793170 4.19.76-linuxkit #1 SMP Tue May 26 11:42:35 UTC 2020 x86_64 GNU/Linux
    root@ac7d58793170:/# echo $NGINX_VERSION
    1.23.0

If bash is on the PATH inside the container:

    $ docker exec -it testing bash
    root@ac7d58793170:/# uname -a
    Linux ac7d58793170 4.19.76-linuxkit #1 SMP Tue May 26 11:42:35 UTC 2020 x86_64 GNU/Linux
    root@ac7d58793170:/# echo $NGINX_VERSION
    1.23.0

Shutdown the remove the instance:

    $ docker stop testing
    testing
    $ docker rm testing
    testing

## Credits and References

* [SO How can I run bash in a new container of a docker image?](https://stackoverflow.com/questions/43308319/how-can-i-run-bash-in-a-new-container-of-a-docker-image)
* [Docker Exec Command With Examples](https://devconnected.com/docker-exec-command-with-examples/)
* [Official nginx image](https://hub.docker.com/_/nginx)
