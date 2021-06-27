# Docker Housekeeping

Some simple hoursekeeping commands for Docker.

## Notes

Problem: `no space left on device` when trying to build an image, but there is apparently lots of disk space left?

## Cleanup Commands

### [docker system prune](https://docs.docker.com/engine/reference/commandline/system_prune/)

Remove unused data

### [docker image prune](https://docs.docker.com/engine/reference/commandline/image_prune/)

Remove unused images

### [docker buildx prune](https://docs.docker.com/engine/reference/commandline/buildx_prune/)

Remove build cache

