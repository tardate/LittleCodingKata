# #214 FreeRADIUS Server on macOS

All about running FreeRADIUS Server on macOS, both native build, and with Docker.

## Notes

The FreeRADIUS Server is the leading open source (GNU GPLv2) implementation of RADIUS. It claims:

* high performance
* scalable - sites ranging from 10 to 10 million+ users
* highly configurable
* multi-protocol policy server: RADIUS, DHCPv4 and VMPS
* can authenticate users on: 802.1x (WiFi), dialup, PPPoE, VPN's, VoIP, and many others
* supports back-end databases such as MySQL, PostgreSQL, Oracle, Microsoft Active Directory, Apache Cassandra, Redis, OpenLDAP, and many more

## Native Build on macOS

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

The default server site config is in `/usr/local/etc/raddb/sites-enabled/default`

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

    cd freeradius-server
    sudo make uninstall

### Removing talloc

If installed with brew:

    brew uninstall talloc

If compiled from source

    cd talloc-2.1.2
    sudo make uninstall

## Running with Docker

Pull a FreeRADIUS Image

    docker pull freeradius/freeradius-server:latest

Create a local config directory so configs persist:

    mkdir -p freeradius-config

Copy default config from container:

    docker run --rm freeradius/freeradius-server:latest \
      tar cf - /etc/freeradius \
      | tar xf - -C ./freeradius-config --strip-components=2

Add a test user in [freeradius-config/users](./freeradius-config/users)

    testuser Cleartext-Password := "testpass"

Allow local client in [freeradius-config/clients.conf](./freeradius-config/clients.conf)

    client localhost {
        ipaddr = 127.0.0.1
        secret = testing123
    }

Allow client network in [freeradius-config/clients.conf](./freeradius-config/clients.conf)

    client private-network-1 {
      ipaddr  = 192.168.65.0/24
      secret  = testing123-1
    }

Run FreeRADIUS using local config:

    $ docker run --rm --name freeradius \
      -p 1812:1812/udp \
      -p 1813:1813/udp \
      -v $(pwd)/freeradius-config:/etc/freeradius \
      freeradius/freeradius-server:latest -X
    ...
    Listening on auth address * port 1812 bound to server default
    Listening on acct address * port 1813 bound to server default
    Listening on auth address :: port 1812 bound to server default
    Listening on acct address :: port 1813 bound to server default
    Listening on auth address 127.0.0.1 port 18120 bound to server inner-tunnel
    Listening on proxy address * port 32907
    Listening on proxy address :: port 42199
    Ready to process requests

Test request using `radtest` within the same container:

    $ docker exec -it freeradius \
      radtest testuser testpass 127.0.0.1 0 testing123
    Sent Access-Request Id 71 from 0.0.0.0:33717 to 127.0.0.1:1812 length 78
      User-Name = "testuser"
      User-Password = "testpass"
      NAS-IP-Address = 172.17.0.2
      NAS-Port = 0
      Message-Authenticator = 0x00
      Cleartext-Password = "testpass"
    Received Access-Accept Id 71 from 127.0.0.1:1812 to 127.0.0.1:33717 length 38
      Message-Authenticator = 0x204dc8e98fb3245d73758653c322b8a1

Server log corresponding to the request:

    !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
    BlastRADIUS check: Received packet with Message-Authenticator.
    Setting "require_message_authenticator = true" for client localhost
    !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
    It looks like the client has been updated to protect from the BlastRADIUS attack.
    Please set "require_message_authenticator = true" for client localhost
    !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
    (0) Received Access-Request Id 71 from 127.0.0.1:33717 to 127.0.0.1:1812 length 78
    (0)   Message-Authenticator = 0xd6ef6362a7430744daa9b8f7bcbcb292
    (0)   User-Name = "testuser"
    (0)   User-Password = "testpass"
    (0)   NAS-IP-Address = 172.17.0.2
    (0)   NAS-Port = 0
    (0) # Executing section authorize from file /etc/freeradius/sites-enabled/default
    (0)   authorize {
    (0)     policy filter_username {
    (0)       if (&User-Name) {
    (0)       if (&User-Name)  -> TRUE
    (0)       if (&User-Name)  {
    (0)         if (&User-Name =~ / /) {
    (0)         if (&User-Name =~ / /)  -> FALSE
    (0)         if (&User-Name =~ /@[^@]*@/ ) {
    (0)         if (&User-Name =~ /@[^@]*@/ )  -> FALSE
    (0)         if (&User-Name =~ /\.\./ ) {
    (0)         if (&User-Name =~ /\.\./ )  -> FALSE
    (0)         if ((&User-Name =~ /@/) && (&User-Name !~ /@(.+)\.(.+)$/))  {
    (0)         if ((&User-Name =~ /@/) && (&User-Name !~ /@(.+)\.(.+)$/))   -> FALSE
    (0)         if (&User-Name =~ /\.$/)  {
    (0)         if (&User-Name =~ /\.$/)   -> FALSE
    (0)         if (&User-Name =~ /@\./)  {
    (0)         if (&User-Name =~ /@\./)   -> FALSE
    (0)       } # if (&User-Name)  = notfound
    (0)     } # policy filter_username = notfound
    (0)     [preprocess] = ok
    (0)     [chap] = noop
    (0)     [mschap] = noop
    (0)     [digest] = noop
    (0) suffix: Checking for suffix after "@"
    (0) suffix: No '@' in User-Name = "testuser", looking up realm NULL
    (0) suffix: No such realm "NULL"
    (0)     [suffix] = noop
    (0) eap: No EAP-Message, not doing EAP
    (0)     [eap] = noop
    (0) files: users: Matched entry testuser at line 43
    (0)     [files] = ok
    (0)     [expiration] = noop
    (0)     [logintime] = noop
    (0)     [pap] = updated
    (0)   } # authorize = updated
    (0) Found Auth-Type = PAP
    (0) # Executing group from file /etc/freeradius/sites-enabled/default
    (0)   Auth-Type PAP {
    (0) pap: Login attempt with password
    (0) pap: Comparing with "known good" Cleartext-Password
    (0) pap: User authenticated successfully
    (0)     [pap] = ok
    (0)   } # Auth-Type PAP = ok
    (0) # Executing section post-auth from file /etc/freeradius/sites-enabled/default
    (0)   post-auth {
    (0)     if (session-state:User-Name && reply:User-Name && request:User-Name && (reply:User-Name == request:User-Name)) {
    (0)     if (session-state:User-Name && reply:User-Name && request:User-Name && (reply:User-Name == request:User-Name))  -> FALSE
    (0)     update {
    (0)       No attributes updated for RHS &session-state:
    (0)     } # update = noop
    (0)     [exec] = noop
    (0)     policy remove_reply_message_if_eap {
    (0)       if (&reply:EAP-Message && &reply:Reply-Message) {
    (0)       if (&reply:EAP-Message && &reply:Reply-Message)  -> FALSE
    (0)       else {
    (0)         [noop] = noop
    (0)       } # else = noop
    (0)     } # policy remove_reply_message_if_eap = noop
    (0)     if (EAP-Key-Name && &reply:EAP-Session-Id) {
    (0)     if (EAP-Key-Name && &reply:EAP-Session-Id)  -> FALSE
    (0)   } # post-auth = noop
    (0) Sent Access-Accept Id 71 from 127.0.0.1:1812 to 127.0.0.1:33717 length 38
    (0) Finished request
    Waking up in 4.9 seconds.
    (0) Cleaning up request packet ID 71 with timestamp +14 due to cleanup_delay was reached
    Ready to process requests

## Credits and References

* <http://freeradius.org/> - main FreeRADIUS site
* <https://en.wikipedia.org/wiki/FreeRADIUS>
* <https://github.com/FreeRADIUS/freeradius-server>
* <https://hub.docker.com/r/freeradius/freeradius-server/>
* [FreeRADIUS - Building on MAC OSX](http://wiki.freeradius.org/building/build#building-from-source_building-on-mac-osx)
* [talloc](https://talloc.samba.org/talloc/doc/html/index.html)
