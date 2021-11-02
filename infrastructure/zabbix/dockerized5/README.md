# Zabbix 5 Docker

Running Zabbix 5 with Docker

## Notes

Multiple [docker images](https://www.zabbix.com/container_images) are available for Zabbix to suit a range of deployment topologies.

The old all-in-one zabbix-appliance image, which was ideal for local testing, is no longer updated for version 5.
It is now necessary to orchestrate multiple containers even for a simple test setup.
This describes the simplest-possible-way (that I know of so far).

### Required Docker Images

For a minimal deployment with MySQL database storage:

* Zabbix agent - zabbix/zabbix-agent
* Zabbix server with MySQL database support - zabbix/zabbix-server-mysql
* Zabbix web-interface based on Apache2 web server with MySQL database support - zabbix/zabbix-web-apache-mysql
* mysql:8.0

Alternative/additional images not used:

* Zabbix server with PostgreSQL database support - zabbix/zabbix-server-pgsql
* Zabbix web-interface based on Apache2 web server with PostgreSQL database support - zabbix/zabbix-web-apache-pgsql
* Zabbix web-interface based on Nginx web server with PostgreSQL database support - zabbix/zabbix-web-nginx-pgsql
* Zabbix web-interface based on Nginx web server with MySQL database support - zabbix/zabbix-web-nginx-mysql
* Zabbix agent 2 - zabbix/zabbix-agent2
* Zabbix proxy with SQLite3 database support - zabbix/zabbix-proxy-sqlite3
* Zabbix proxy with MySQL database support - zabbix/zabbix-proxy-mysql
* Zabbix Java Gateway - zabbix/zabbix-java-gateway
* SNMP trap support - zabbix/zabbix-snmptraps

### Running the Zabbix Appliance

The [docker-compose.yml](./docker-compose.yml?raw=true) is setup for running Zabbix appliance with MySQL data persisted in a volume.

It also starts a separate zabbix agent container that can monitor the zabbix appliance container itself.
The agent container is linked the the server container so that the agent can perform active checks.

```
$ docker-compose up -d
```

On first startup, the web interface will be available on [0.0.0.0:8081](http://0.0.0.0:8081) with default credentials `Admin/zabbix`

![initial_dashboard](./assets/initial_dashboard.png?raw=true)


```
$ $ docker ps
CONTAINER ID        IMAGE                                              COMMAND                  CREATED             STATUS                   PORTS                              NAMES
5eccf809e066        zabbix/zabbix-web-apache-mysql:alpine-5.4-latest   "docker-entrypoint.s…"   2 minutes ago       Up 2 minutes (healthy)   8443/tcp, 0.0.0.0:8081->8080/tcp   dockerized5_zabbix-web-apache-mysql_1
40a35deab67c        zabbix/zabbix-server-mysql:alpine-5.4-latest       "/sbin/tini -- /usr/…"   2 minutes ago       Up 2 minutes             0.0.0.0:10051->10051/tcp           dockerized5_zabbix-server_1
6e8570399d81        mysql:8.0                                          "docker-entrypoint.s…"   2 minutes ago       Up 2 minutes                                                dockerized5_mysql-server_1
1e64f8a45ac8        zabbix/zabbix-agent:alpine-5.4-latest              "/sbin/tini -- /usr/…"   2 minutes ago       Up 2 minutes                                                dockerized5_zabbix-agent_1
```

The agent hostname needed to be updated in order to find the agent container at `zabbix-agent:10050`:

![agent_configured](./assets/agent_configured.png?raw=true)

Now we have basic monitoring of the zabbix server via the zabbix agent:

![updated_dashboard](./assets/updated_dashboard.png?raw=true)

![zabbix_server_activity](./assets/zabbix_server_activity.png?raw=true)

Shutting down and checking volumes

```
$ docker-compose down
$ docker volume ls | grep zabbix5
local               dockerized5_zabbix5-db
```

The [zabbix_control.sh](./zabbix_control.sh?raw=true) wraps up some simple commands to start and stop the containers,
get logs and open a shell.

## Credits and References

* [Zabbix Container Images Overview](https://www.zabbix.com/container_images)
* [Official Zabbbx Images](https://hub.docker.com/u/zabbix) - docker hub
* [Official Zabbix Dockerfiles](https://github.com/zabbix/zabbix-docker) - github
* [Installation from containers](https://www.zabbix.com/documentation/current/manual/installation/containers) - docs
