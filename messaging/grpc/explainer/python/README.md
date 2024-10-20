# #018 Explainer - Python Version

This sample implements a Python version of the
[Explainer Protocol](../protocols/explainer.proto).

The Explainer is totally inspired by Natalie Silvanovich's
[Hardware Excuse Generator](http://natashenka.ca/hardware-excuse-generator/)

## Generate Protocol Stubs

This generates the [explainer_pb2.py](./explainer_pb2.py) protocol implementation.

```
$ protoc -I ../protocols --python_out=. --grpc_out=. --plugin=protoc-gen-grpc=`which grpc_python_plugin` ../protocols/explainer.proto
```

## Install and Tests

```
$ pip install -r requirements.txt
```

## Test Drive - Python Client and Server

I don't have a python server implementation yet, so using the [ruby version](../ruby)
Start the server in one console window..

```
$ cd ../ruby
$ ./explainer.rb
ShiFu is waiting to explain all of your problems...

```

Now try the python client in another:

```
$ python explain.py

Here's some help:

Describe your problem in a sentence, using the text "REASON" where-ever you'd like a good excuse inserted

e.g. "Glitching was not a viable attack because of REASON"

$ python explain.py "Your phone is probably crashing because of REASON"
Your phone is probably crashing because of minor ESD damage to coil
$ python explain.py "Your phone is probably crashing because of REASON"
Your phone is probably crashing because of thermal effects in the resistor R3
$ python explain.py "Your phone is probably crashing because of REASON"
Your phone is probably crashing because of internal resistance of the antenna
$ python explain.py "Your phone is probably crashing because of REASON"
Your phone is probably crashing because of residual capacitance caused by the USB connector
$ python explain.py "Your phone is probably crashing because of REASON"
Your phone is probably crashing because of the EEPROM inducing current in the pull-up resistor
```

## Credits and References
* [gRPC docs](http://www.grpc.io/docs/)
* [gRPC Python](https://github.com/grpc/grpc/tree/release-0_13/src/python/grpcio)
* [Hardware Excuse Generator](http://natashenka.ca/hardware-excuse-generator/)
* [excusegen - GitHub](https://github.com/natashenka/excusegen)
