# Cacti

About the cacti network monitoring tool, including how to run it in Docker.

## Notes

[Cacti](https://www.cacti.net/) is a network graphing/monitoring tool that uses RRD time-series files for storage.
It is one of the many tools that are part of the [RRDtool](https://en.wikipedia.org/wiki/RRDtool) ecosystem.

### Features

Graphs

* graph templates
* tree view for graph hierarchies
* list view
* preview view
* support for all of RRDTool's graph item types including AREA, STACK, LINE[1-3], GPRINT, COMMENT, VRULE, and HRULE.

Data Sources - uses RRD files via RRDTool library

Data Gathering

* custom scripts that can be used to gather data
* built-in SNMP support, ability to retrieve data using SNMP or a script with an index
* cacti provides the poller: Spine, formerly Cactid

User Management - for defining users, permissions. Users can have their own graph settings.

What it doesn't have:

* there's no API for management/configuration
* there's no API for data access/queries


### Requirements

Cacti requires MySQL, PHP, RRDTool, net-snmp, and a webserver that supports PHP such as Apache or IIS.

### Running in Docker

Traditionally, cacti is directly installed on a suitable Linux or Windows host - see [downloads](https://www.cacti.net/download_cacti.php).

But with so many dependencies, running in Docker is a very attractive option these days. A brief scan of dockerhub
shows there are no official images, but two reasonably popular attempts:

* [smcline06](https://hub.docker.com/r/smcline06/cacti)
* [polinux](https://hub.docker.com/r/polinux/cacti)

The smcline06 version appears to have the more active [github repo](https://github.com/scline/docker-cacti) so I'm trying that.

I'm using a [docker-compose.yml](./docker-compose.yml?raw=true) based on the [smcline06 single-instance example](https://github.com/scline/docker-cacti/tree/master/docker-compose).

```
$ docker-compose up
```

After initial startup, logging into [localhost](http://0.0.0.0) with default credentials `admin/admin` will prompt for a password change
and then proceed with a guided installation process.

![install_success](./assets/install_success.png?raw=true)

I configured automatic discovery on the local network. There's not much to find, but I see my mobile phone there (pocophone)..

![discovery](./assets/discovery.png?raw=true)

Adding my phone as a generic device..

![add_generic_device](./assets/add_generic_device.png?raw=true)

And it's monitored with ping. Shows it going offine when I went out with the phone..

![graphs](./assets/graphs.png?raw=true)


Shutting down...

```
$ docker-compose down
```

The docker compose configuration defines a number of named volumes.
They remain after shutown, ready to be reused on startup.
If I wasn't planning to reuse the cacti isntallation, I could removed them with `docker volume rm`

```
$ docker volume ls | grep cacti
local               cacti_cacti-backups
local               cacti_cacti-data
local               cacti_cacti-db
```

## Credits and References

* [cacti.net](https://www.cacti.net/)
* [RRDtool](https://en.wikipedia.org/wiki/RRDtool) - wikipedia
* [RRDtool](https://oss.oetiker.ch/rrdtool/) - project home
* [rrdtool-1.x](https://github.com/oetiker/rrdtool-1.x) - source
