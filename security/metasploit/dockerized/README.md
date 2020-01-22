# Running Metasploit with Docker

Investigating how to run Metasploit in a Docker container

## Notes

Various Docker images for Metasploit have been published over the years,
but it seems the best to start with today are the official images in the [metasploitframework dockerhub](https://hub.docker.com/r/metasploitframework/metasploit-framework).

## Running a Self-contained Image with Docker

The [msf_control.sh](./msf_control.sh?raw=true) solo option runs a selected image in docker
without a default database connection or any local file mapping

`$ ./msf_control.sh solo`

![msf_start](./assets/msf_start.png?raw=true)


## Running the Console and Database with Docker Compose

The [msf_control.sh](./msf_control.sh?raw=true) script wraps some simple docker-compose commands
that fire up a postgres db instance and the metasploit console in linked containers.
Storage is mapped to the local file system:

* `mymsf/.msf5`
* `mymsf/pg_data`

Starting a metasploit console session:

`$ ./msf_control.sh ms`

![msf_console](./assets/msf_console.png?raw=true)

### Running Some Simple Commands

nmap tcp scan, high ports only:

```
msf5 > nmap -sT -p1-1024 192.168.1.1
[*] exec: nmap -sT -p1-1024 192.168.1.1

Starting Nmap 7.70 ( https://nmap.org ) at 2020-01-25 15:15 UTC
Nmap scan report for SunshineFleur (192.168.1.1)
Host is up (0.0091s latency).
Not shown: 1019 closed ports
PORT    STATE    SERVICE
53/tcp  open     domain
80/tcp  open     http
139/tcp open     netbios-ssn
443/tcp filtered https
445/tcp open     microsoft-ds

Nmap done: 1 IP address (1 host up) scanned in 2.62 seconds
```

nmap stealth scan:

```
msf5 > nmap -sS 192.168.1.1
[*] exec: nmap -sS 192.168.1.1

Starting Nmap 7.70 ( https://nmap.org ) at 2020-01-25 15:14 UTC
Nmap scan report for SunshineFleur (192.168.1.1)
Host is up (0.011s latency).
Not shown: 992 closed ports
PORT      STATE    SERVICE
53/tcp    open     domain
80/tcp    open     http
139/tcp   open     netbios-ssn
443/tcp   filtered https
445/tcp   open     microsoft-ds
10000/tcp open     snet-sensor-mgmt
49152/tcp open     unknown
49153/tcp open     unknown

Nmap done: 1 IP address (1 host up) scanned in 2.97 seconds
```

### Logging and Importing an nmap scan

Since we're in docker, choosing to write the log to  `~/.msf4` which is mapped to local file system.

Running a scan with XML output:
```
msf5 > nmap -sT -oX ~/.msf4/nmap_1.xml 192.168.1.1
[*] exec: nmap -sT -oX ~/.msf4/nmap_1.xml 192.168.1.1

Starting Nmap 7.70 ( https://nmap.org ) at 2020-01-25 15:34 UTC
Nmap scan report for SunshineFleur (192.168.1.1)
Host is up (0.022s latency).
Not shown: 992 closed ports
PORT      STATE    SERVICE
53/tcp    open     domain
80/tcp    open     http
139/tcp   open     netbios-ssn
443/tcp   filtered https
445/tcp   open     microsoft-ds
10000/tcp open     snet-sensor-mgmt
49152/tcp open     unknown
49153/tcp open     unknown

Nmap done: 1 IP address (1 host up) scanned in 1.53 seconds
```

checking db connectivity and importing the scan..

```
msf5 > db_status
[*] Connected to msf?pool=200&timeout=5. Connection type: postgresql. Connection name: Km2oS7BO.
msf5 > db_import ~/.msf4/nmap_1.xml
[*] Importing 'Nmap XML' data
[*] Import: Parsing with 'Nokogiri v1.10.7'
[*] Importing host 192.168.1.1
[*] Successfully imported /home/msf/.msf4/nmap_1.xml
msf5 > hosts

Hosts
=====

address      mac  name           os_name  os_flavor  os_sp  purpose  info  comments
-------      ---  ----           -------  ---------  -----  -------  ----  --------
192.168.1.1       SunshineFleur  Unknown                    device

msf5 > services
Services
========

host         port   proto  name              state     info
----         ----   -----  ----              -----     ----
192.168.1.1  53     tcp    domain            open
192.168.1.1  80     tcp    http              open
192.168.1.1  139    tcp    netbios-ssn       open
192.168.1.1  443    tcp    https             filtered
192.168.1.1  445    tcp    microsoft-ds      open
192.168.1.1  10000  tcp    snet-sensor-mgmt  open
192.168.1.1  49152  tcp    unknown           open
192.168.1.1  49153  tcp    unknown           open


```

## Credits and References

* [metasploit](https://www.metasploit.com)
* [metasploitframework dockerhub](https://hub.docker.com/r/metasploitframework/metasploit-framework)
* [metasploit docs](https://metasploit.help.rapid7.com/docs)
* [metasploit external resource portal](http://resources.metasploit.com/)
* [nmap.org](https://nmap.org/)
