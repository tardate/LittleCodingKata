# LittleCodingKata

Like many programmers, I have a folder that I've been carrying around for years
into which I've squirrelled away all manner of tests, notes, tips and tricks. Occasionally I've thought about
making the repo public, but as-is, it's a real grab-bag of semi-intelligible snippets
and I can't be sure just how much confidential info may be in there.

So I decided to start again here, and hopefully rebuild a more useful collection in the open by
applying a similar discipline to how I've been building up my [LittleArduinoProjects](https://github.com/tardate/LittleArduinoProjects)
collection of microcontroller and electronics projects.

So here goes..

To be precise, the purpose of this repo is to collect my programming exercises, research and code toys
broadly spanning things that relate to programming and software development (that includes languages, frameworks and tools).

These may range from the trivial to the complex and serious. Many will be inspired by existing work and I'll note the credits
and references where applicable. And it will appear quite scatter-brained, as I variously work on things new and important in the moment,
or go back to revisit things from the past.

This is primarily a personal collection for my own edification and learning, but anyone who stumbles by is welcome to borrow, steal
or reference the work here. And if you spot errors or issues I'd really appreciate some feedback - create an issue, send me an email
or even send a pull-request.

## Bash

* [case statements](./bash/case_statement)

## Haskell

* [About Haskell](./haskell/about) - my tl;dr summary
* [Hello World](./haskell/hello_world)
* [installing on MacOSX](./haskell/install_macosx)

## Javascript

* [Progress Bars with Bootstrap](./javascript/progress_bars_bootstrap)

## Messaging Infrastructure

### gRPC

* [installing on MacOSX](./messaging/grpc/install_macosx)
* [The Explainer](./messaging/grpc/explainer) - hardware excuse generator with gRPC
  - [The Explainer (C++)](./messaging/grpc/explainer/cpp) - C++ client example
  - [The Explainer (C#)](./messaging/grpc/explainer/csharp) - C# client example
  - [The Explainer (Node.js)](./messaging/grpc/explainer/node) - Node client example
  - [The Explainer (Python)](./messaging/grpc/explainer/python) - Python client example
  - [The Explainer (Ruby)](./messaging/grpc/explainer/ruby) - Ruby client and server example

## Python

* [quirks - late-bound closures](./python/quirks/late_bound_closures)
* [quirks - mutable default params](./python/quirks/mutable_default_params)
* [random_mac_generation](./python/random_mac_generation) - all about MAC and generating random MAC addresses
* [top_level_imports](./python/top_level_imports) - or: why not to put an __init__.py in your top level folder
* [twisted_client_server](./python/twisted_client_server) - writing client-server code with twisted and tests
* [twisted_web_client](./python/twisted_web_client) - writing web client code with twisted and tests

## Ruby

* [random_mac_generation](./ruby/random_mac_generation) - all about MAC and generating random MAC addresses

## Rust

* [About Rust](./rust/about) - my tl;dr summary
* [Hello World](./rust/hello_world) - with concurrency
* [installing on MacOSX](./rust/install_macosx)

## Tools

* [envsubst](./tools/envsubst) - substitute shell variables in text
* [homebrew](./tools/homebrew) - homebrew (MacOSX package manager) tips and tricks
* [iproute2](./tools/iproute2) - about iproute2 and how to run it on MacOSX
