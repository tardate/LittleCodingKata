# Building for ARM with Docker

Building 32-bit ARM v7 images with docker, tested on MacOSX and AWS.

## Notes

I'm running on MacOSX and have access to Linux/AMD64 machines,
but want to build a Docker image for 32-bit ARM v7 that I could then use with older Raspberry Pi or Odriod devices.

Here's a demonstration of one way to do it, using [Docker Buildx](https://docs.docker.com/buildx/working-with-buildx/).

### Docker Buildx

[Docker Buildx](https://docs.docker.com/buildx/working-with-buildx/) is a CLI plugin that includes cross-platform build capability.

With Docker Desktop for Mac, buildx is available after enabling experimental features

![enable_experimental_features](./assets/enable_experimental_features.png?raw=true)

Buildx availability can be confirmed by listing builders:

```
$ docker buildx ls
NAME/NODE DRIVER/ENDPOINT STATUS  PLATFORMS
default * docker
  default default         running linux/amd64, linux/arm64, linux/riscv64, linux/ppc64le, linux/s390x, linux/386, linux/arm/v7, linux/arm/v6
```

NB: if `BUILDX_NO_DEFAULT_LOAD` environment variable is not set, build commands will throw a warning.
Interestingly, there are many references to be found about the warning message, but little if any detail
on what `BUILDX_NO_DEFAULT_LOAD` is for in the first place. As far as I can figure:

* setting `true` will mean that build result will only remain in the build cache if no moby driver is available
* probably want it to be false (the default)
* see sources in [build.go](https://github.com/docker/buildx/blob/master/build/build.go#L1058)

## Testing a basic linux/amd64 image

The [armi](./armi) project includes a simple diagnostic program in c - based on the example from
[Getting started with Docker for Arm on Linux](https://www.docker.com/blog/getting-started-with-docker-for-arm-on-linux/)

The default builder can only build for a simple platform at a time.
First I'll build for linux/amd64 and test it running on MacOSX.

```
cd armi
$ docker buildx build --platform linux/amd64 -t tardate/armi:amd64 .
...
 => exporting to image
 => => exporting layers
 => => writing image sha256:e62a7447cd15f6e9dfcc13eaa7dcbe49e3c892d546d200005aa8538403a1289c
 => => naming to docker.io/tardate/armi:amd64
$ docker run --rm tardate/armi:amd64
Hello, my architecture is Linux buildkitsandbox 4.19.76-linuxkit #1 SMP Tue May 26 11:42:35 UTC 2020 x86_64 Linux
$ docker run --rm -it --entrypoint sh tardate/armi:amd64
/home # ls
build.log  hello      hello.c
/home # cat build.log
I am running on linux/amd64, building for linux/amd64
```

Note:
* I'm not pushing an image to a remote repository at this stage (no `--push` parameter)
* the default build knows how to load the image for docker use - hence `exporting to image...` step
* with non-default builders, I had to add the `--load` parameter to tell them to export the image for local docker use

## Building for ARM

```
$ docker buildx build --platform linux/arm/v7 -t tardate/armi:arm .
$ docker run --rm tardate/armi:arm
Hello, my architecture is Linux buildkitsandbox 4.19.76-linuxkit #1 SMP Tue May 26 11:42:35 UTC 2020 armv7l Linux
$ docker run --rm -it --entrypoint sh tardate/armi:arm
/home # ls
build.log  hello      hello.c
/home # cat build.log
I am running on linux/amd64, building for linux/arm/v7
/home #
```


## Building multi-platform images

I need to create a builder that will support multi-platform builds. I gave ti the random name `myxbuilder`:

```
$ docker buildx create --name myxbuilder
$ docker buildx inspect myxbuilder --bootstrap
Name:   myxbuilder
Driver: docker-container

Nodes:
Name:      myxbuilder0
Endpoint:  unix:///var/run/docker.sock
Status:    running
Platforms: linux/amd64, linux/arm64, linux/riscv64, linux/ppc64le, linux/s390x, linux/386, linux/arm/v7, linux/arm/v6
```

Switching to use `myxbuilder`, I can build and push images to docker hub:

```
$ docker buildx use myxbuilder
$ docker buildx build --platform linux/arm/v7,linux/amd64 -t tardate/armi . --push
```

Inspecting the image manifest from docker hub, I see the two platform versions available under the same tag:

```
$ docker buildx imagetools inspect tardate/armi:latest
Name:      docker.io/tardate/armi:latest
MediaType: application/vnd.docker.distribution.manifest.list.v2+json
Digest:    sha256:fd9a3e0a54242ab3fd9c102ae617b2974aaee97c396d1bb66225a4e78844d409

Manifests:
  Name:      docker.io/tardate/armi:latest@sha256:e10bbaedfbbe5053cdcbc406ff87cff3da28c866fa3901a67b67f261d05baede
  MediaType: application/vnd.docker.distribution.manifest.v2+json
  Platform:  linux/arm/v7

  Name:      docker.io/tardate/armi:latest@sha256:b9aa5b0c52abe4f00ae27499088ce751380c60b662a3a25fdc8e6e6757d1ff0e
  MediaType: application/vnd.docker.distribution.manifest.v2+json
  Platform:  linux/amd64
```

Here's how it appears at [https://hub.docker.com/r/tardate/armi/tags](https://hub.docker.com/r/tardate/armi/tags):

![docker_hub_armi](./assets/docker_hub_armi.png?raw=true)


Running these images by specific tag:

```
$ docker run --rm tardate/armi:latest@sha256:e10bbaedfbbe5053cdcbc406ff87cff3da28c866fa3901a67b67f261d05baede
Hello, my architecture is Linux buildkitsandbox 4.19.76-linuxkit #1 SMP Tue May 26 11:42:35 UTC 2020 armv7l Linux
$ docker run --rm tardate/armi:latest@sha256:b9aa5b0c52abe4f00ae27499088ce751380c60b662a3a25fdc8e6e6757d1ff0e
Hello, my architecture is Linux buildkitsandbox 4.19.76-linuxkit #1 SMP Tue May 26 11:42:35 UTC 2020 x86_64 Linux
```

## Running the ARM Image on AWS

Roughly following the guide from [Setting up an Arm server](https://developer.arm.com/documentation/102475/0100/Setting-up-an-Arm-server)..

It seems that no cloud providers offer 32 bit instances any longer - [Scaleway](https://www.scaleway.com) used for have 32 bit AMD "C1" machines but they have long since been retired.

AWS does offer 64 bit AMD instances, so I will test the docker image there (should not have any issue with 32 bit image).

Here's the basic cookbook:

From EC2 dashboard and select Launch Instance. I selected Amazon Linux 2 AMI 64 bit ARM t4g.micro.

Once SSH access has been established, install docker support:

```
sudo yum update -y
sudo amazon-linux-extras install docker
sudo usermod -a -G docker ec2-user
sudo service docker start
```

Attempting to run the image without qualification fails since there is no 64 bit image
```
$ docker run --rm tardate/armi
Unable to find image 'tardate/armi:latest' locally
latest: Pulling from tardate/armi
docker: no matching manifest for linux/arm64/v8 in the manifest list entries.
See 'docker run --help'.
```

However, by explicitly specifying arm v7 (32 bit) I am able to run the image:

```
$ docker run --platform=linux/arm/v7 --rm tardate/armi
Unable to find image 'tardate/armi:latest' locally
latest: Pulling from tardate/armi
... etc
Hello, my architecture is Linux buildkitsandbox 4.19.76-linuxkit #1 SMP Tue May 26 11:42:35 UTC 2020 armv7l Linux
```

![asw_arm_run](./assets/asw_arm_run.png?raw=true)

## Credits and References

* [Getting started with Docker for Arm on Linux](https://www.docker.com/blog/getting-started-with-docker-for-arm-on-linux/)
* [name](https://www.docker.com/blog/multi-arch-build-and-images-the-simple-way/)
* [Multi-architecture images](https://developer.arm.com/documentation/102475/0100/Multi-architecture-images) - ARM
* [Setting up an Arm server](https://developer.arm.com/documentation/102475/0100/Setting-up-an-Arm-server)
