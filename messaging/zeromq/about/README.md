# About Zeromq

Zeromq in a nutshell with a quick test of using the library from C.

## Notes

Zeromq is

* also known as zmq, 0mq, 0MQ
* an open-source universal messaging library - see [github](https://github.com/zeromq)
* is language and platform agnostic

Zeromq:

* carries messages across inproc, IPC, TCP, UDP, TIPC, multicast and WebSocket
* supports multiple messaging models:  fan-out, pub-sub, task distribution, and request-reply
* is broker-less by default (though you could build a broker with 0mq)

## Checking the Library Version

The [version.c](./version.c) is a quick check that the library is installed and usable from C.
Using the Makefile...

```
$ make
gcc -Wall -O3 `pkg-config --cflags libzmq`    version.c  `pkg-config --libs libzmq` -o version
./version
Current 0MQ version is 4.3.2
```

## Credits and References

* [zeromq](https://zeromq.org)
* [zeromq](https://github.com/zeromq) - github
* [zeromq](http://zguide.zeromq.org/page:all) - the guide
* [zmq_version](http://api.zeromq.org/2-1:zmq-version) - api doc
