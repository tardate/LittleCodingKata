# #022 Explainer - Ruby Version

This sample implements a Ruby client and server that talk the
[Explainer Protocol](../protocols/explainer.proto).

The Explainer is totally inspired by Natalie Silvanovich's
[Hardware Excuse Generator](http://natashenka.ca/hardware-excuse-generator/)

## Generate Protocol Stubs

```
$ mkdir lib  # it's not automatic
$ protoc -I ../protocols --ruby_out=lib --grpc_out=lib --plugin=protoc-gen-grpc=`which grpc_ruby_plugin` ../protocols/explainer.proto
```

## Install and Tests

A Gemfile is provided to setup an environment and install the right gems.
`bundle` to install as usual..

```
$ bundle
```

I've written a few tests (just the parser functionality so far)

```
$ ./test_parser.rb
Run options: --seed 23181

# Running:

.......

Finished in 0.003182s, 2200.0900 runs/s, 12257.6443 assertions/s.

7 runs, 39 assertions, 0 failures, 0 errors, 0 skips
```

All good for a test drive...


## Test Drive - Ruby Client and Server

Start the server in one console window..

```
$ ./explainer.rb
ShiFu is waiting to explain all of your problems...

```

Now try the client in another:

```
$ ./explain.rb

Here's some help:

Describe your problem in a sentence, using the text "REASON" where-ever you'd like a good excuse inserted

e.g. "Glitching was not a viable attack because of REASON"

$ ./explain.rb "Your phone is probably crashing because of REASON"
Your phone is probably crashing because of the PCB not being manufactured to specification
$ ./explain.rb "Your phone is probably crashing because of REASON"
Your phone is probably crashing because of electromagnetic resonance
$ ./explain.rb "Your phone is probably crashing because of REASON"
Your phone is probably crashing because of jitter in the antenna clock
$ ./explain.rb "Your phone is probably crashing because of REASON"
Your phone is probably crashing because of the susceptibility of resistor R3 to ESD
$ ./explain.rb "Your phone is probably crashing because of REASON"
Your phone is probably crashing because of a lack of shielding against alpha radiation (cosmic rays) in EEPROM
```


## Credits and References
* [gRPC docs](http://www.grpc.io/docs/)
* [gRPC Ruby](https://github.com/grpc/grpc/tree/release-0_13/src/ruby)
* [Hardware Excuse Generator](http://natashenka.ca/hardware-excuse-generator/)
* [excusegen - GitHub](https://github.com/natashenka/excusegen)
