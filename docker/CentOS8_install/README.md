# Docker on CentOS 8

Installing and running Docker on CentOS 8

## Notes

Using a fresh instance with CentOS 8: 4.18.0-80.11.2.el8_0.x86_64

### Installation

Pre-requisites and addition repo (using dnf instead of yum now):

```
sudo dnf install yum-utils device-mapper-persistent-data lvm2
sudo dnf config-manager --add-repo=https://download.docker.com/linux/centos/docker-ce.repo
```

Finding the latest docker-ce release:
```
$ dnf list docker-ce
Last metadata expiration check: 0:02:52 ago on Tue 18 Feb 2020 10:02:49 AM EST.
Available Packages
docker-ce.x86_64                                                        3:19.03.6-3.el7                                                         docker-ce-stable
```

NB: to see all available versions: `dnf list docker-ce --showduplicates | sort -r`


Install:

```
$ sudo dnf install docker-ce-3:19.03.6-3.el7
Error:
 Problem: package docker-ce-3:19.03.6-3.el7.x86_64 requires containerd.io >= 1.2.2-3, but none of the providers can be installed

```

Picking form the CentOS 7 repo: https://download.docker.com/linux/centos/7/x86_64/stable/Packages/

```
sudo dnf install https://download.docker.com/linux/centos/7/x86_64/stable/Packages/containerd.io-1.2.6-3.3.el7.x86_64.rpm
```

Try again:

```
sudo dnf install docker-ce-3:19.03.6-3.el7
```

All good so far:

```
$ sudo systemctl enable --now docker
Created symlink /etc/systemd/system/multi-user.target.wants/docker.service → /usr/lib/systemd/system/docker.service.
$ docker --version
Docker version 19.03.6, build 369ce74a3c
```

A quick test:

```
$ sudo docker run -it --rm alpine:latest ping google.com -c3
Unable to find image 'alpine:latest' locally
latest: Pulling from library/alpine
c9b1b535fdd9: Pull complete
Digest: sha256:ab00606a42621fb68f2ed6ad3c88be54397f981a7b70a79db3d1172b11c4367d
Status: Downloaded newer image for alpine:latest
PING google.com (172.217.164.238): 56 data bytes
64 bytes from 172.217.164.238: seq=0 ttl=55 time=4.119 ms
64 bytes from 172.217.164.238: seq=1 ttl=55 time=4.250 ms
64 bytes from 172.217.164.238: seq=2 ttl=55 time=4.169 ms

--- google.com ping statistics ---
3 packets transmitted, 3 packets received, 0% packet loss
round-trip min/avg/max = 4.119/4.179/4.250 ms
```

NB: if there was an issue with DNS resolution within Docker containers, suggestion is that the firewalld must be disabled e.g. `sudo systemctl disable firewalld`

Add user to the docker group `sudo usermod -aG docker $USER` so can now run without sudo:

```
$ docker run -it --rm alpine:latest ping google.com -c3
PING google.com (172.217.1.174): 56 data bytes
64 bytes from 172.217.1.174: seq=0 ttl=55 time=4.093 ms
64 bytes from 172.217.1.174: seq=1 ttl=55 time=3.774 ms
64 bytes from 172.217.1.174: seq=2 ttl=55 time=3.871 ms

--- google.com ping statistics ---
3 packets transmitted, 3 packets received, 0% packet loss
round-trip min/avg/max = 3.774/3.912/4.093 ms
```


### Installing Docker Compose


$ sudo curl -L https://github.com/docker/compose/releases/download/1.25.0/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
$ docker-compose --version
docker-compose version 1.25.0, build 0a186604


## Credits and References

* [Get Docker Engine - Community for CentOS](https://docs.docker.com/install/linux/docker-ce/centos/#prerequisites)
* [How to install Docker CE on CentOS 8](https://www.techrepublic.com/article/how-to-install-docker-ce-on-centos-8/)
* [Docker Release Notes](https://docs.docker.com/engine/release-notes/)
* [DNF (Dandified YUM)](https://en.wikipedia.org/wiki/DNF_(software)) - wikipedia
* [A quick guide to DNF for yum users](https://opensource.com/article/18/8/guide-yum-dnf)
* [centos8 docker installation](https://www.codetd.com/en/article/9228087)
* [Install and Use Docker Compose on CentOS 8](https://www.howtoforge.com/install-and-use-docker-compose-on-centos-8/)
