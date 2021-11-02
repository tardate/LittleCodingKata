# arping

All about Address Resolution Protocol (ARP - RFC826) and installing arping on MacOS.

## Notes

The arping utility sends an ARP REQUEST to a neighbour host.
The Address Resolution Protocol (ARP - RFC826) is used to discover the link layer address (i.e. MAC address) for a given internet layer address, typically an IPv4 address.


## Installing on MacOS

arping is available for installation with [homebrew](https://github.com/Homebrew/homebrew)

```
brew install arping

The formula built, but is not symlinked into /usr/local
Could not symlink sbin/arping
/usr/local/sbin is not writable.

You can try again using:
  brew link arping
==> Summary
🍺  /usr/local/Cellar/arping/2.19: 6 files, 76KB
/usr/local/Cellar/arping/2.19/sbin/arping
```

Note that it wasn't able to link the binary in `/usr/local/sbin`

This is usually solved by ensuring the directory exists and set permissions:

```
sudo mkdir /usr/local/sbin
sudo chown -R `whoami`:admin /usr/local/sbin
```

Then links correctly:

```
$ brew link arping
Linking /usr/local/Cellar/arping/2.19... 2 symlinks created
$ export PATH=$PATH:/usr/local/sbin
$ which arping
/usr/local/sbin/arping

```

## Test Drive

```
$ arping -I en0 -c 2 192.168.0.14
ARPING 192.168.0.14
42 bytes from 48:5a:3f:6f:6a:80 (192.168.0.14): index=0 time=184.923 msec
42 bytes from 48:5a:3f:6f:6a:80 (192.168.0.14): index=1 time=102.294 msec

--- 192.168.0.14 statistics ---
2 packets transmitted, 2 packets received,   0% unanswered (0 extra)
rtt min/avg/max/std-dev = 102.294/143.608/184.923/41.314 ms

```


## Credits and References
* [arping](https://linux.die.net/man/8/arping) - man page
* [homebrew](https://github.com/Homebrew/homebrew)
* [Address Resolution Protocol](https://en.wikipedia.org/wiki/Address_Resolution_Protocol) - wikipedia
