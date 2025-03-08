# #020 gRPC Explainer - C# Version

This sample implements a C# version of the
[Explainer Protocol](../protocols/explainer.proto).

The Explainer is totally inspired by Natalie Silvanovich's
[Hardware Excuse Generator](http://natashenka.ca/hardware-excuse-generator/)

## Generate Protocol Stubs

This generates the [Explainer.cs](./explain/Explainer.cs) and [ExplainerGrpc.cs](./explain/ExplainerGrpc.cs) protocol implementation and stubs.

```sh
protoc -I ../protocols --csharp_out=./explain --grpc_out=. --plugin=protoc-gen-grpc=`which grpc_csharp_plugin` ../protocols/explainer.proto
```

## Build

I'm building this on macOS with mono 4.2.3

```sh
$ mono --version
Mono JIT compiler version 4.2.3 (explicit/832de4b Thu Mar  3 19:24:57 EST 2016)
Copyright (C) 2002-2014 Novell, Inc, Xamarin Inc and Contributors. www.mono-project.com
  TLS:           normal
  SIGSEGV:       altstack
  Notification:  kqueue
  Architecture:  x86
  Disabled:      none
  Misc:          softdebug
  LLVM:          yes(3.6.0svn-mono-(detached/a173357)
  GC:            sgen
```

The project was setup with Xamarin Studio.
Open the [explain/explain.sln](./explain/explain.sln) solution and build the project.
It should also be possible to build it without issues on Windows with Visual Studio.

Alternatively, it can be built from the command line:

```sh
$ cd explain
$ bin/nuget install ./packages.config -OutputDirectory ./packages
[...etc till done...]
$ xbuild /p:Configuration=Release explain.sln
```

## Test Drive - C# Client

I don't have a c# server implementation yet, so using the [ruby version](../ruby)
Start the server in one console window..

```sh
$ cd ../ruby
$ ./explainer.rb
ShiFu is waiting to explain all of your problems...

```

Now try the c# client in another:

```sh
$ cd explain
$ mono bin/Release/explain.exe

Here's some help:

Describe your problem in a sentence, using the text "REASON" where-ever you'd like a good excuse inserted

e.g. "Glitching was not a viable attack because of REASON"

$ mono bin/Release/explain.exe "Your phone is probably crashing because of REASON"
Your phone is probably crashing because of a lack of shielding against alpha radiation (cosmic rays) in button
$ mono bin/Release/explain.exe "Your phone is probably crashing because of REASON"
Your phone is probably crashing because of stray harmonics
$ mono bin/Release/explain.exe "Your phone is probably crashing because of REASON"
Your phone is probably crashing because of thermal effects in the pull-up resistor
$ mono bin/Release/explain.exe "Your phone is probably crashing because of REASON"
Your phone is probably crashing because of pull-up resistor being placed too close to pull-up resistor on the PCB
$ mono bin/Release/explain.exe "Your phone is probably crashing because of REASON"
Your phone is probably crashing because of voltage gitches in the battery
```

## Credits and References

* [gRPC docs](http://www.grpc.io/docs/)
* [gRPC Basics: C#](http://www.grpc.io/docs/tutorials/basic/csharp.html)
* [Hardware Excuse Generator](http://natashenka.ca/hardware-excuse-generator/)
* [excusegen - GitHub](https://github.com/natashenka/excusegen)
* [nuget.sh](https://gist.github.com/andypiper/2636885) - example nuget with mono
* [For the record: How to run NuGet.exe on OS X Mountain Lion](https://orientman.wordpress.com/2012/12/29/for-the-record-how-to-run-nuget-exe-on-os-x-mountain-lion/)
