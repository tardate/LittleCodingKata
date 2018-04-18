# FreeRADIUS Client


[:arrow_forward: return to the Catalog](https://codingkata.tardate.com)

## Notes

FreeRADIUS Client is a C framework and library for writing RADIUS Clients.

So far this is a fail. Builds OK, but I hit issues trying to get clients built with this library to talk to
the FreeRADIUS Server. KIV for now.


## Mac OS X Build

The steps to build and install are in `./download_and_make`:

    git clone git@github.com:FreeRADIUS/freeradius-client.git
    cd freeradius-client
    autoreconf -fvi && ./configure && make && sudo make install


* installs client sample programs to `/usr/local/sbin`
* installs client configs to `/usr/local/etc/radiusclient`
* installs the libfreeradius-client to `/usr/local/lib`

Edit `/usr/local/etc/radiusclient/servers` to set the shared secret

    localhost/localhost                             testing123


Examples:
* radacct
* radembedded - how to embed the configuration of a radius client, using the FreeRADIUS Client Library without an external configuration file
* radexample - example skeleton client
* radiusclient
* radlogin
* radstatus - get RADIUS server status

## Test: radstatus

OK, first client test...

```
/usr/local/sbin/radstatus
RADIUS: Status failure
RADIUS: Status failure
```

Hmm, not good. Client is not picking up the shared secret and no hint on the server that it receved a request.

From `src/radstatus.c`..
```
/* FIX ME FIX ME FIX ME
 * This is broken, now that send_server requires the secret to be passed
 * It will need to be collected as an additional argument on command line
 */
```

OK, looks like this client library needs a bit of maintenance, certainly a bit more study than I'm prepared to do right now


## Credits and References
* [freeradius-client](https://github.com/FreeRADIUS/freeradius-client) - GitHub
* [freeradius-client](http://wiki.freeradius.org/project/Radiusclient) - Documentation
* [How to install and use autotools on Mac OS X](https://paolozaino.wordpress.com/2015/05/05/how-to-install-and-use-autotools-on-mac-os-x/comment-page-1/)
* [OS X Mavericks Server – Setting Up FreeRADIUS](https://www.yesdevnull.net/2013/10/os-x-mavericks-server-setting-up-freeradius/)
