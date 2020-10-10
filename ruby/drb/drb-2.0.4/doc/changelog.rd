= dRuby ChangeLog

* 2.0?
  * timeridconv.rb: rename class TimerIdConv -> DRb::TimerIdConv
  * timeridconv.rb: generational GC :)
  * AF_UNIX, SSL support.
  * Add drb/gw.rb.
  * acl.rd, acl-ref.rd, drb-ref.rd: make the English "flow" better. (Hugh Sasse <hgs@dmu.ac.uk>)

* 1.3.6
  * drb.c: untaint uri (for $SAFE=1).
  * runit/drbunit.rb: Add $SAFE=1 test.

* 1.3.5
  * lib/drb/extserv*.rb: Change ExtServManager#regist protocol.
  * runit/ut_port.rb: Adjust a port number
  * lib/drb/drb.rb: Add DRb::DRbServer.verbose, verbose=, #verbose=, #verbose.
  * lib/drb/drb.rb: Use Object.__id__ insted of Object.id.

* 1.3.4.2
  * dRuby development version.
  * No change in dRuby itself.
  * Move "drb over http" scripts from lib to sample directory.
  * Fix a bug in drbunit.rb.

* 1.3.4
  * Add new sample, distribute cdbiff client and server.
  * Fix "yield" make a mistake its argument.
  * Fix exchange large message; revert sysread/syswrite to read/write.
  * Handle SOL_TCP.
  * Add DRb::DRbObservable module.

* 1.3.3
  * Try to reuse connection (for performance improvement).
  * DRbObject returns the object, when URI is matched with remote.
  * Now DRbUnknownError can go and return.
  * Add hash.eql? to drb/rq.rb.
  * Add close on exec flag.

