# FreeRADIUS Server on MacOS


## Notes

The FreeRADIUS Server is the leading open source (GNU GPLv2) implementation of RADIUS. IT claims:
* high performance
* scalable - sites ranging from 10 to 10 million+ users
* highly configurable
* multi-protocol policy server: RADIUS, DHCPv4 and VMPS
* can authenticate users on: 802.1x (WiFi), dialup, PPPoE, VPN's, VoIP, and many others
* supports back-end databases such as MySQL, PostgreSQL, Oracle, Microsoft Active Directory, Apache Cassandra, Redis, OpenLDAP, and many more

## Build on MacOS

### Installing talloc

`talloc` is a pre-requisite:

* `brew install talloc`
* or install from source - handled by `download_and_make`


### Build and Install

The steps to build and install are in `./download_and_make`

Installation drops files in the following locations:
* /usr/local/bin
* /usr/local/sbin
* /usr/local/var/log/radius
* /usr/local/etc/raddb

Default locations used by the radius server are configured in `/usr/local/etc/raddb/radiusd.conf`.

The installation transcript for my test install is in [installation_transcript.log](./installation_transcript.log).

## Test Drive

### Starting the Server

Start the server in daemon mode:

    sudo /usr/local/sbin/radiusd

Or foreground debug mode:

    sudo /usr/local/sbin/radiusd -X


`radtest` is installed in /usr/local/bin and can be used to test the server. Usage:

    Usage: radtest [OPTIONS] user passwd radius-server[:port] nas-port-number secret [ppphint] [nasname]

Attempt to authenticate. I haven't setup this user yet, so it is expected to fail:

    radtest test test localhost 0 testing123
      Socket: 5
      Proto:  17
      Src IP: 0.0.0.0
        port: 63378
      Dst IP: 127.0.0.1
        port: 1812
      Code:   (1) Access-Request
      Id:   14
      Length: 74
      Vector: b567e473a0dae669f1dc49359ea4d82b
      Data:   01  06  74 65 73 74
        02  12  d9 57 d0 5f 6d 05 e4 5c a6 9d 04 a8 03 8b f9 7c
        04  06  c0 a8 00 0f
        05  06  00 00 00 00
        50  12  3d bd 55 57 9b 7f dd d1 3e 91 cd 8c 60 4d 4c 70
    Sent Access-Request Id 14 from 0.0.0.0:63378 to 127.0.0.1:1812 length 74
      User-Name = "test"
      User-Password = "test"
      NAS-IP-Address = 192.168.0.15
      NAS-Port = 0
      Message-Authenticator = 0x00
      Cleartext-Password = "test"
    Received Access-Reject Id 14 from 127.0.0.1:1812 to 0.0.0.0:0 via lo0 length 20
    (0) -: Expected Access-Accept got Access-Reject

That's expected & good. It's working!

### Reviewing the server config

The defualt server site config is in `/usr/local/etc/raddb/sites-enabled/default`

A few things to note:

    auth_log # uncommented, to enable log of authentication requests

    #
    #  Read the 'users' file.  In v3, this is located in
    #  raddb/mods-config/files/authorize
    files

Adding a user `/usr/local/etc/raddb/mods-config/files/authorize`. Uncomment the `bob` account:

    #
    # The canonical testing user which is in most of the
    # examples.
    #
    bob     Cleartext-Password := "hello"
            Reply-Message := "Hello, %{User-Name}"

Restart the server, and test authentication:

    $ radtest bob hello localhost 0 testing123
      Socket: 5
      Proto:  17
      Src IP: 0.0.0.0
        port: 60754
      Dst IP: 127.0.0.1
        port: 1812
      Code:   (1) Access-Request
      Id:   23
      Length: 73
      Vector: 64b3d1e258aa051f59457cfe4f5ac633
      Data:   01  05  62 6f 62
        02  12  0f 2a 46 6e ba 04 03 75 40 c6 ea f0 df 88 7a a6
        04  06  c0 a8 00 0f
        05  06  00 00 00 00
        50  12  46 47 e1 f1 00 19 04 16 c7 61 8e b2 56 df 8c 64
    Sent Access-Request Id 23 from 0.0.0.0:60754 to 127.0.0.1:1812 length 73
      User-Name = "bob"
      User-Password = "hello"
      NAS-IP-Address = 192.168.0.15
      NAS-Port = 0
      Message-Authenticator = 0x00
      Cleartext-Password = "hello"
    Received Access-Accept Id 23 from 127.0.0.1:1812 to 0.0.0.0:0 via lo0 length 32
      Reply-Message = "Hello, bob"

Success!

### Removing

```
cd freeradius-server
sudo make uninstall
```

### Removing talloc

If installed with brew:
```
brew uninstall talloc
```

If compiled from source
```
cd talloc-2.1.2
sudo make uninstall
```

## Credits and References
* [FreeRADIUS](http://freeradius.org/) - main site
* [FreeRADIUS](https://en.wikipedia.org/wiki/FreeRADIUS) - wikipedia
* [FreeRADIUS](https://github.com/FreeRADIUS/freeradius-server) - GitHub
* [FreeRADIUS - Building on MAC OSX](http://wiki.freeradius.org/building/build#building-from-source_building-on-mac-osx)
* [talloc](https://talloc.samba.org/talloc/doc/html/index.html)
