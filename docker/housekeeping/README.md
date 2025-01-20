# #269 Docker Housekeeping

Some simple housekeeping commands for Docker.

## Notes

Problem: `no space left on device` when trying to build an image, but there is apparently lots of disk space left?

## Cleanup Commands

### [docker system prune](https://docs.docker.com/engine/reference/commandline/system_prune/)

This will remove:

- all stopped containers
- all networks not used by at least one container
- all dangling images
- all dangling build cache

### [docker image prune](https://docs.docker.com/engine/reference/commandline/image_prune/)

This will remove:

- all dangling images

### [docker volume prune](https://docs.docker.com/engine/reference/commandline/volume_prune/)

This will remove:

- all local volumes not used by at least one container

### [docker buildx prune](https://docs.docker.com/engine/reference/commandline/buildx_prune/)

Removes build cache.

## Using Until Filter

These commands accept an `until`.

Relative times are allowed e.g.

    docker image prune --filter "until=48h"

in addition to absolute date e.g.

    docker image prune --filter "until=2021-07-01"

## Credits and References

- [How to remove old and unused Docker images](https://stackoverflow.com/questions/32723111/how-to-remove-old-and-unused-docker-images/32723127)
- [Simple script needed to delete all docker images over 4 weeks old](https://forums.docker.com/t/simple-script-needed-to-delete-all-docker-images-over-4-weeks-old/28558)
- [How do I delete a docker image from docker hub via command line?](https://stackoverflow.com/questions/44209644/how-do-i-delete-a-docker-image-from-docker-hub-via-command-line)
- [How to delete a Docker image tag from Docker Hub registry](https://devopsheaven.com/docker/dockerhub/2018/04/09/delete-docker-image-tag-dockerhub.html)
