# #359 Chat CLI

Build and update the CLI chat example from Rust lang: The complete beginner's guide, learning about making client-server network programs with Rust.

## Notes

This project is adapted from an example given in the
[Rust lang: The complete beginner's guide](https://www.udemy.com/course/rustaceans/) course. Dependencies and code have been updated to work cleanly in 2025.

## Server

See [./chat_server/src/main.rs](chat_server/src/main.rs)

The server listens to messages on an IP and port (<http://127.0.0.1:6000> by default).

When a message is received, it is logged to the console and broadcast to all clients (including the sending client)

Key implementation notes:

* server listening port is established using the <https://doc.rust-lang.org/std/net/struct.TcpListener.html> standard library
* each client connection is monitored on its own thread
* send and received channels are synchronised using <https://doc.rust-lang.org/std/sync/mpsc/fn.channel.html>

## Client

See [./chat_client/src/main.rs](chat_client/src/main.rs)

Any number of clients may be started. When started, it connects to the server (<http://127.0.0.1:6000> by default).

* Any message entered in the client is sent to the server.
* All messages received are logged to the screen
* The client may be ended by typing ":quit" or ctrl-C

Key implementation notes:

* server connection is established using the <https://doc.rust-lang.org/std/net/struct.TcpStream.html> standard library
* server messages are constantly monitored and received in a background thread
* the foreground thread handles user messages to be sent
* send and received channels are synchronised using <https://doc.rust-lang.org/std/sync/mpsc/fn.channel.html>

## Example Usage

Run the server:

```sh
$ cd chat_server
$ cargo run
    Finished `dev` profile [unoptimized + debuginfo] target(s) in 0.00s
     Running `target/debug/chat_server`
Client 127.0.0.1:49686 connected
127.0.0.1:49686: "hello from 1"
Client 127.0.0.1:49687 connected
127.0.0.1:49687: "hello from 2"
127.0.0.1:49686: "saying bye from 1"
Closing connection with 127.0.0.1:49686
127.0.0.1:49687: "saying bye from 2"
Closing connection with 127.0.0.1:49687
```

Start a client session:

```sh
$ cd chat_client/
$ cargo run
    Finished `dev` profile [unoptimized + debuginfo] target(s) in 0.00s
     Running `target/debug/chat_client`
Write a message:
hello from 1
Message sent "hello from 1"
message received [104, 101, 108, 108, 111, 32, 102, 114, 111, 109, 32, 49]
 -> "hello from 1"
message received [104, 101, 108, 108, 111, 32, 102, 114, 111, 109, 32, 50]
 -> "hello from 2"
saying bye from 1
Message sent "saying bye from 1"
message received [115, 97, 121, 105, 110, 103, 32, 98, 121, 101, 32, 102, 114, 111, 109, 32, 49]
 -> "saying bye from 1"
:quit
bye
$
```

Start a second client in parallel

```sh
$ cd chat_client/
$ cargo run
    Finished `dev` profile [unoptimized + debuginfo] target(s) in 0.00s
     Running `target/debug/chat_client`
Write a message:
hello from 2
Message sent "hello from 2"
message received [104, 101, 108, 108, 111, 32, 102, 114, 111, 109, 32, 50]
 -> "hello from 2"
message received [115, 97, 121, 105, 110, 103, 32, 98, 121, 101, 32, 102, 114, 111, 109, 32, 49, 27, 91, 68, 27, 91, 68, 27, 91, 68, 27, 91, 68, 27, 91, 68]
 -> "saying bye from 1\u{1b}[D\u{1b}[D\u{1b}[D\u{1b}[D\u{1b}[D"
message received [115, 97, 121, 105, 110, 103, 32, 98, 121, 101, 32, 102, 114, 111, 109, 32, 49]
 -> "saying bye from 1"
saying bye from 2
Message sent "saying bye from 2"
message received [115, 97, 121, 105, 110, 103, 32, 98, 121, 101, 32, 102, 114, 111, 109, 32, 50]
 -> "saying bye from 2"
^C
$
```

## Credits and References

* [Rust lang: The complete beginner's guide](https://www.udemy.com/course/rustaceans/)
* <https://doc.rust-lang.org/std/net/struct.TcpListener.html>
* <https://doc.rust-lang.org/std/net/struct.TcpStream.html>
* <https://doc.rust-lang.org/std/sync/mpsc/fn.channel.html>
