# Basic Request-Reply in C

Basic ZeroMQ 'hello world' example of the request-reply messaging pattern in C.

## Notes

A simple example that demonstrates a basic request-reply pattern, exchanging string messages in C.

Key points:

* [zmq-socket](http://api.zeromq.org/3-2:zmq-socket) is created within a [zmq-ctx-new](http://api.zeromq.org/3-2:zmq-ctx-new) context.
  * `ZMQ_REQ` is used by a client to send requests to and receive replies from a service. each reply received is matched with the last issued request
  * `ZMQ_REP` is used by a service to receive requests from and send replies to a client. each reply sent is routed to the client that issued the last request
* [zmq-bind](http://api.zeromq.org/3-2:zmq-bind) is used by the server to listen on unicast transport using TCP
* [zmq-connect](http://api.zeromq.org/3-2:zmq-connect) is used by the client to connect to the server on pre-agreed port
* [zmq-send](http://api.zeromq.org/3-2:zmq-send) and [zmq-recv](http://api.zeromq.org/3-2:zmq-recv) used by both client and server.
* strings are sent as just bytes. Safe conversion to null-terminated C strings is the responsibility of the program using ZeroMQ. The examples read messages into `{0}` initialised buffers to avoid problems.

### Running the Example

Build the project..

```
$ make
gcc -Wall -O3 `pkg-config --cflags libzmq`    client.c  `pkg-config --libs libzmq` -o client
gcc -Wall -O3 `pkg-config --cflags libzmq`    server.c  `pkg-config --libs libzmq` -o server
```

Start up the server..

```
$ ./server
Server is listening for connections on tcp:5555...
Received request msg: 'REQ #0', recv_size: 6, strlen: 6
Replying with msg: 'REP to REQ #0', strlen: 13
Received request msg: 'REQ #1', recv_size: 6, strlen: 6
Replying with msg: 'REP to REQ #1', strlen: 13
Received request msg: 'REQ #2', recv_size: 6, strlen: 6
Replying with msg: 'REP to REQ #2', strlen: 13
Received request msg: 'REQ #3', recv_size: 6, strlen: 6
Replying with msg: 'REP to REQ #3', strlen: 13
Received request msg: 'REQ #4', recv_size: 6, strlen: 6
Replying with msg: 'REP to REQ #4', strlen: 13
Received request msg: 'REQ #5', recv_size: 6, strlen: 6
Replying with msg: 'REP to REQ #5', strlen: 13
Received request msg: 'REQ #6', recv_size: 6, strlen: 6
Replying with msg: 'REP to REQ #6', strlen: 13
Received request msg: 'REQ #7', recv_size: 6, strlen: 6
Replying with msg: 'REP to REQ #7', strlen: 13
Received request msg: 'REQ #8', recv_size: 6, strlen: 6
Replying with msg: 'REP to REQ #8', strlen: 13
Received request msg: 'REQ #9', recv_size: 6, strlen: 6
Replying with msg: 'REP to REQ #9', strlen: 13
^C
```

Then start up a client...

```
$ ./client
Connecting to the server on tcp:5555...
Sending 'REQ #0', strlen=6 ...
Received reply #0: 'REP to REQ #0', recv_size: 13, strlen: 13
Sending 'REQ #1', strlen=6 ...
Received reply #1: 'REP to REQ #1', recv_size: 13, strlen: 13
Sending 'REQ #2', strlen=6 ...
Received reply #2: 'REP to REQ #2', recv_size: 13, strlen: 13
Sending 'REQ #3', strlen=6 ...
Received reply #3: 'REP to REQ #3', recv_size: 13, strlen: 13
Sending 'REQ #4', strlen=6 ...
Received reply #4: 'REP to REQ #4', recv_size: 13, strlen: 13
Sending 'REQ #5', strlen=6 ...
Received reply #5: 'REP to REQ #5', recv_size: 13, strlen: 13
Sending 'REQ #6', strlen=6 ...
Received reply #6: 'REP to REQ #6', recv_size: 13, strlen: 13
Sending 'REQ #7', strlen=6 ...
Received reply #7: 'REP to REQ #7', recv_size: 13, strlen: 13
Sending 'REQ #8', strlen=6 ...
Received reply #8: 'REP to REQ #8', recv_size: 13, strlen: 13
Sending 'REQ #9', strlen=6 ...
Received reply #9: 'REP to REQ #9', recv_size: 13, strlen: 13
```


## Credits and References

* [zmq-ctx-new](http://api.zeromq.org/3-2:zmq-ctx-new)
* [zmq-socket](http://api.zeromq.org/3-2:zmq-socket)
* [zmq-bind](http://api.zeromq.org/3-2:zmq-bind)
* [zmq-connect](http://api.zeromq.org/3-2:zmq-connect)
* [zmq-send](http://api.zeromq.org/3-2:zmq-send)
* [zmq-recv](http://api.zeromq.org/3-2:zmq-recv)
