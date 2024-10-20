# #204


## Notes

IPROUTE2 Utility Suite was written by Alexey N. Kuznetsov for manipulating the Linux 2.2-2.6 network interface code.
There are others, but `ip` is the main program it includes.

Here's a rough summary of what `ip` can do:

* `ip link` - network device configuration
* `ip address` - protocol address management
* `ip neighbour` - neighbour/arp table management
* `ip route` - routing table management
* `ip rule` - routing policy database management
* `ip tunnel` - ip tunnelling configuration

### iproute2mac

iproute2 is not included in Mac OS X distributions.

[iproute2mac](https://github.com/brona/iproute2mac) is a CLI wrapper for basic network utilities
that provides a somewhat-compatible `ip` command. It seems good enough for most common cases,
and so far it hasn't let me down when I've wanted to work on scripts written for Linux that incidentally use `ip` for some purpose.

The main functionality missing in iproute2mac are the `ip rule` and `ip tunnel` command sets, and all the other iproute2 functions not included in `ip`.

When iproute2mac's `ip` runs out of steam, it's necessary fallback on `netstat`, `ifconfig`, `ndp`, `arp`, `route` and `networksetup` directly.

### Installation and test drive on MacOS

I use [homebrew](https://github.com/Homebrew/homebrew) to manage most of my software installation,
and wadiyano, there's a formula available:

```
$ brew install iproute2mac
$ ip link show en0
en0: flags=8863<UP,BROADCAST,SMART,RUNNING,SIMPLEX,MULTICAST> mtu 1500
  ether 78:31:c1:c8:3f:60
  nd6 options=1<PERFORMNUD>
  media: autoselect
  status: active
$ ip addr show en0
en0: flags=8863<UP,BROADCAST,SMART,RUNNING,SIMPLEX,MULTICAST> mtu 1500
  ether 78:31:c1:c8:3f:60
  inet6 fe80::7a31:c1ff:fec8:3f60/64 scopeid 0x4
  inet 192.168.0.17/24 brd 192.168.0.255 en0
  inet6 2406:3003:2063:3d:7a31:c1ff:fec8:3f60/128 dynamic
$ ip route
default via 192.168.0.1 dev en0
127.0.0.0/8 via 127.0.0.1 dev lo0
169.254.0.0/16 dev en0  scope link
192.168.0.0/24 dev en0  scope link
192.168.0.1/32 dev en0  scope link
192.168.0.17/32 dev en0  scope link
```

## Credits and References

* [iproute2](http://www.policyrouting.org/iproute2.doc.html) - the original
* [github.com/brona/iproute2mac](https://github.com/brona/iproute2mac)
* [ip command in Mac OS X terminal](http://superuser.com/questions/687310/ip-command-in-mac-os-x-terminal) - where I found out about iproute2mac
