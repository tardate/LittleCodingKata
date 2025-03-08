# #292 Installing gRPC for macOS

Getting gRPC running under macOS

## Notes

To use gRPC, we need:

* gRPC runtime for the language(s) used
* depending on your chosen language, may need the protocol buffers compiler

This should be simplified in future releases.

## Install protocol buffer compiler

There are at least two methods:

* source compilation - see [protobuf GitHub](https://github.com/google/protobuf)
* brew - see [gRPC Homebrew](https://github.com/grpc/homebrew-grpc)

### brew

I use [homebrew](https://github.com/Homebrew/homebrew) to manage most of my software installation, so I'll try that first.

    $ brew update  # make sure brew is up to date
    $ brew tap grpc/grpc
    ==> Tapping grpc/grpc
    Cloning into '/usr/local/Library/Taps/grpc/homebrew-grpc'...
    remote: Counting objects: 10, done.
    remote: Compressing objects: 100% (8/8), done.
    remote: Total 10 (delta 0), reused 5 (delta 0), pack-reused 0
    Unpacking objects: 100% (10/10), done.
    Checking connectivity... done.
    Tapped 2 formulae (37 files, 43K)
    $ brew install --without-libgrpc grpc
    [...]
    Editor support and examples have been installed to:
      /usr/local/Cellar/google-protobuf/3.0.0-beta-2/share/doc/google-protobuf
    ==> Summary
      /usr/local/Cellar/google-protobuf/3.0.0-beta-2: 330 files, 16.2M, built in 2 minutes 17 seconds
    ==> Installing grpc/grpc/grpc
    ==> Downloading https://github.com/grpc/grpc/archive/release-0_13_0.tar.gz
    ==> Downloading from https://codeload.github.com/grpc/grpc/tar.gz/release-0_13_0
    ######################################################################## 100.0%
    ==> make install-plugins prefix=/usr/local/Cellar/grpc/0.13.0
      /usr/local/Cellar/grpc/0.13.0: 9 files, 281K, built in 21 seconds
    $ protoc --version
    libprotoc 3.0.0

So far, so good..

And then later I needed the gRPC C core library (i.e. shouldn't have used --without-libgrpc), so re-installed:

    $ brew uninstall grpc
    [...]
    $ brew install grpc
    [...]
    $ protoc --version
    libprotoc 3.0.0
    $ which grpc_cpp_plugin
    /usr/local/bin/grpc_cpp_plugin
    $ ls /usr/local/include/grpc*
    /usr/local/include/grpc:
    byte_buffer.h   census.h    grpc.h      grpc_zookeeper.h  status.h
    byte_buffer_reader.h  compression.h   grpc_security.h   impl      support

    /usr/local/include/grpc++:
    channel.h   completion_queue.h  generic     impl      server.h    server_context.h
    client_context.h  create_channel.h  grpc++.h    security    server_builder.h  support

Better!

## Credits and References

* [Install gRPC](http://www.grpc.io/docs/#install-grpc)
* [gRPC Homebrew](https://github.com/grpc/homebrew-grpc)
* [Installing Google Protocol Buffers on mac](http://stackoverflow.com/questions/21775151/installing-google-protocol-buffers-on-mac)
* [protobuf GitHub](https://github.com/google/protobuf)
