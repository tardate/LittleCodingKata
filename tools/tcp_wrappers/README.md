# #127 Wrappers

The basics of TCP wrappers.

## Notes

TCP wrappers is an ACL system for services running on a host, and provide basic traffic filtering.
It is implemented as a library `libwrap` that services must link to be used.

As such, it is mainly useful for real-time response to abuse/suspicious activity with well-known services.
A more complete solution on a host is a software firewall like `iptables` or `nftables`.

These days, most hosts are hidden behind a hardware firewall or load balancer endpoints,
so the amount of direct traffic they would receive from the unfiltered Internet may be minimal.

### Basic Usage

Checking if a service is using tcp wrappers:

```
$ ldd $(which sshd) | grep libwrap
  libwrap.so.0 => /lib64/libwrap.so.0 (0x00007f1fea580000)
```

Rules are defined in

* `/etc/hosts.allow`
* `/etc/hosts.deny`

e.g.

```
$ cat /etc/hosts.deny
sshd: 222.186.*
```

Who was that trying to brute force a root login?

```
$ whois  222.186.31.166
...
inetnum:        222.184.0.0 - 222.191.255.255
netname:        CHINANET-JS
descr:          CHINANET jiangsu province network
descr:          China Telecom
descr:          A12,Xin-Jie-Kou-Wai Street
descr:          Beijing 100088
country:        CN
admin-c:        CH93-AP
tech-c:         CJ186-AP
mnt-by:         APNIC-HM
mnt-lower:      MAINT-CHINANET-JS
mnt-routes:     MAINT-CHINANET-JS
mnt-irt:        IRT-CHINANET-CN
remarks:        --------------------------------------------------------
remarks:        To report network abuse, please contact mnt-irt
remarks:        For troubleshooting, please contact tech-c and admin-c
remarks:        Report invalid contact via www.apnic.net/invalidcontact
remarks:        --------------------------------------------------------
status:         ALLOCATED PORTABLE
last-modified:  2020-02-04T05:38:43Z
...
```

### Peeking at the source

```
wget https://ftp.osuosl.org/pub/blfs/conglomeration/tcp_wrappers/tcp_wrappers_7.6.tar.gz
tar zxvf tcp_wrappers_7.6.tar.gz
rm tcp_wrappers_7.6.tar.gz
```

From a quick read:

* `tcpd` is the main wrapper daemon
* inetd is "tricked" into running tcpd instead of the indended service (like `sshd`)
* `tcpd` accpets requests, filters and logs as appropriate then passes the connection off to the intended service daemon

## Credits and References

* [man tcpd](https://linux.die.net/man/8/tcpd)
* [Understanding TCP Wrappers](https://www.thegeekdiary.com/understanding-tcp-wrappers-in-linux/)
* [TCP Wrappers](https://en.wikipedia.org/wiki/TCP_Wrappers) - wikipedia
