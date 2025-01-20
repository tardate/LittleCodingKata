# #019 gRPC Explainer - C++ Version

This sample implements a C++ version of the
[Explainer Protocol](../protocols/explainer.proto).

The Explainer is totally inspired by Natalie Silvanovich's
[Hardware Excuse Generator](http://natashenka.ca/hardware-excuse-generator/)

## Install and Build

Install the gRPC C core library first.

The generation of protocol stubs is handled by the make file, so just:

```
$ make
protoc -I ../protocols --cpp_out=. ../protocols/explainer.proto
g++ -std=c++11 -I/usr/local/include -pthread  -c -o explainer.pb.o explainer.pb.cc
protoc -I ../protocols --grpc_out=. --plugin=protoc-gen-grpc=`which grpc_cpp_plugin` ../protocols/explainer.proto
g++ -std=c++11 -I/usr/local/include -pthread  -c -o explainer.grpc.pb.o explainer.grpc.pb.cc
g++ -std=c++11 -I/usr/local/include -pthread  -c -o explain.o explain.cc
g++ explainer.pb.o explainer.grpc.pb.o explain.o -L/usr/local/lib -lgrpc++_unsecure -lgrpc -lprotobuf -lpthread -ldl -o explain

```

## Test Drive - C++ Client and Server

I don't have a C++ server implementation yet, so using the [ruby version](../ruby)
Start the server in one console window..

```
$ cd ../ruby
$ ./explainer.rb
ShiFu is waiting to explain all of your problems...

```

Now try the C++ client in another:

```
$ ./explain

Here's some help:

Describe your problem in a sentence, using the text "REASON" where-ever you'd like a good excuse inserted

e.g. "Glitching was not a viable attack because of REASON"

$ ./explain "Your phone is probably crashing because of REASON"
Your phone is probably crashing because of voltage gitches in the capacitor C1
$ ./explain "Your phone is probably crashing because of REASON"
Your phone is probably crashing because of voltage spikes in the battery
$ ./explain "Your phone is probably crashing because of REASON"
Your phone is probably crashing because of impedance in the coil
$ ./explain "Your phone is probably crashing because of REASON"
Your phone is probably crashing because of excessive bridging loss
$ ./explain "Your phone is probably crashing because of REASON"
Your phone is probably crashing because of residual capacitance caused by the button
$ ./explain "Your phone is probably crashing because of REASON"
Your phone is probably crashing because of electromagnetic interference
$ ./explain "Your phone is probably crashing because of REASON"
Your phone is probably crashing because of excessive heat emitted by the button

```

## Credits and References
* [gRPC docs](http://www.grpc.io/docs/)
* [gRPC C++](https://github.com/grpc/grpc/tree/master/src/cpp)
* [Hardware Excuse Generator](http://natashenka.ca/hardware-excuse-generator/)
* [excusegen - GitHub](https://github.com/natashenka/excusegen)


