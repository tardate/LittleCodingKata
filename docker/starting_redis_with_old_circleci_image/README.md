# #078 Redis with and old CircleCI Image

Notes on dealing with a Redis issue on an old Ubuntu 14.04 docker image with CircleCI

## Notes

When I migrated some Ruby/Rails projects to CircleCI 2.0, the migration scripts recommended
using an `ubuntu-14.04-XXL-upstart-1189-5614f37` docker image.

Everything was working fine until 13-Aug-2019 when the redis-server start commands begain to fail.
These are old, unmaintained images now, but they still have Redis installed correctly.
They are just unable to start the redis server using the conventional service control commands.

I still don't know what the root cause is, but it appears to be a new incompatibility between ubuntu upstart and redis.
But I found a workaround for the short-term (better to probably move these applications to more recent and maintained docker images).

### Testing the Image

To find out what was going on, I ran the images locally to see what was going on with the redis startup.

Pulling the docker image

    $ docker image pull circleci/build-image:ubuntu-14.04-XXL-upstart-1189-5614f37
    ...
    Digest: sha256:c43b32467f43bd1294541eebf65ac082a234d8f7261ff3312c8bbca80e948dc5
    Status: Downloaded newer image for circleci/build-image:ubuntu-14.04-XXL-upstart-1189-5614f37
    $

We have a valid image:

    $ docker image ls | grep XXL
    circleci/build-image                       ubuntu-14.04-XXL-upstart-1189-5614f37   38df34ab2dd8        2 years ago         22.9GB

And can start it up, start the PostgreSQL server etc...

    $ docker run -it circleci/build-image:ubuntu-14.04-XXL-upstart-1189-5614f37 bash
    ...
    # sudo service postgresql status
    9.5/main (port 5432): down
    # sudo service postgresql start
    * Starting PostgreSQL 9.5 database server

But the redis server can no longer startup as a service..

    # sudo service redis-server status
    initctl: Unable to connect to Upstart: Failed to connect to socket /com/ubuntu/upstart: Connection refused
    redis-server: unrecognized service

Redis is installed:

    # apt list --installed redis*
    Listing... Done
    redis-server/trusty,now 2:2.8.4-2 amd64 [installed]
    redis-tools/trusty,now 2:2.8.4-2 amd64 [installed,automatic]

Configuration `/etc/init/redis-server.conf` is present (but not init.d):

    # ls -al /etc/init.d/redis*
    ls: cannot access /etc/init.d/redis*: No such file or directory
    # ls /etc/init/redis-server.conf
    /etc/init/redis-server.conf

Alternative upstart service control commands don't work:

    # sudo start redis-server
    start: Unable to connect to Upstart: Failed to connect to socket /com/ubuntu/upstart: Connection refused

But it is possible to start the server directly:

    # nohup sudo -u redis /usr/bin/redis-server /etc/redis/redis.conf > /dev/null 2>&1 &
    # redis-cli ping
    PONG

### Getting Circle CI Building Again

While it will be better to move to more moderna and maintained images, the following cicleci.yml fragments were enough to get our builds
on the road again...

    docker:
      - image: circleci/build-image:ubuntu-14.04-XXL-upstart-1189-5614f37
    steps:
      ...
      - run:
          name: redis-server start (hacky way)
          command: '(nohup sudo -u redis /usr/bin/redis-server /etc/redis/redis.conf > /dev/null 2>&1 &)'
      - run:
          name: test redis
          command: 'ps auxf ; redis-cli -h 127.0.0.1 -p 6379 ping'
      ...

### Cleaning Up

Listing containers

    $ docker container ls -a | grep XXL
    6ef9a334bcce        circleci/build-image:ubuntu-14.04-XXL-upstart-1189-5614f37   "/sbin/init"             5 months ago        Exited (137) 5 months ago                            cit
    f2b352b4e8af        circleci/build-image:ubuntu-14.04-XXL-upstart-1189-5614f37   "bash"                   5 months ago        Exited (0) 5 months ago                              mystifying_shirley
    95684a6b7f3b        circleci/build-image:ubuntu-14.04-XXL-upstart-1189-5614f37   "bash"                   5 months ago        Exited (100) 5 months ago                            eager_kare

Removing containers by id or name:

    docker container rm cit
    docker container rm 95684a6b7f3b

Removing the image:

    docker image rm circleci/build-image:ubuntu-14.04-XXL-upstart-1189-5614f37

## Credits and References

* [circleci](https://circleci.com/)
* [Sample 2.0 config.yml Files](https://circleci.com/docs/2.0/sample-config/)
* [Running redis using upstart on Ubuntu](https://gist.github.com/bdotdub/714533)
