# #111 Docker

Running Zabbix with Docker

## Notes

Multiple [docker images](https://www.zabbix.com/container_images) are available for Zabbix to suit a range of deployment topologies.

The [Zabbix Appliance](https://hub.docker.com/r/zabbix/zabbix-appliance) image is the basic all-in-one, good for local testing.

### Running the Zabbix Appliance

The [docker-compose.yml](./docker-compose.yml?raw=true) is setup for running Zabbix appliance with MySQL data persisted in a volume.

It also starts a separate zabbix agent container that can monitor the zabbix appliance container itself.
The agent container is linked the the server container so that the agent can perform active checks.

```
$ docker-compose up -d
```

On first startup, the web interface will be available on [0.0.0.0:80](http://0.0.0.0:80) with default credentials `Admin/zabbix`

![initial_dashboard](./assets/initial_dashboard.png?raw=true)


```
$ docker ps
CONTAINER ID        IMAGE                            COMMAND                  CREATED             STATUS              PORTS                                                   NAMES
251884f1a063        zabbix/zabbix-appliance:latest   "/sbin/tini -- /usr/…"   5 minutes ago       Up 5 minutes        0.0.0.0:80->80/tcp, 0.0.0.0:10051->10051/tcp, 443/tcp   dockerized_zabbix-app_1
2083160a135f        zabbix/zabbix-agent:latest       "/sbin/tini -- /usr/…"   5 minutes ago       Up 5 minutes        10050/tcp                                               dockerized_zabbix-agent_1
```

The agent hostname needed to be updated in order to find the agent container at `zabbix-agent:10050`:

![agent_configured](./assets/agent_configured.png?raw=true)

Now we have basic monitoring of the zabbix server via the zabbix agent:

![updated_dashboard](./assets/updated_dashboard.png?raw=true)

![zabbix_server_activity](./assets/zabbix_server_activity.png?raw=true)

Shutting down and checking volumes

```
$ docker-compose down
$ docker volume ls | grep zapp
local               dockerized_zapp-db
```

The [zabbix_control.sh](./zabbix_control.sh?raw=true) wraps up some simple commands to start and stop the appliance container,
get logs and open a shell.

## Credits and References

* [Zabbix Container Images Overview](https://www.zabbix.com/container_images)
* [Official Zabbbx Images](https://hub.docker.com/u/zabbix) - docker hub
* [Official Zabbix Dockerfiles](https://github.com/zabbix/zabbix-docker) - github
* [Installation from containers](https://www.zabbix.com/documentation/current/manual/installation/containers) - docs
