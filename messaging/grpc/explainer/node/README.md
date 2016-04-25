# The Explainer - Node.js Version

This sample implements a Node.js client and server that talk the
[Explainer Protocol](../protocols/explainer.proto).

The Explainer is totally inspired by Natalie Silvanovich's
[Hardware Excuse Generator](http://natashenka.ca/hardware-excuse-generator/)


## Test Drive - Node.js Client

I don't have a node.js server yet, so using the [ruby version](../ruby)
Start the server in one console window..

```
$ cd ../ruby
$ ./explainer.rb
ShiFu is waiting to explain all of your problems...

```

Now try the node.js client in another:

```
$ node ./explain.js

Here's some help:

Describe your problem in a sentence, using the text "REASON" where-ever you'd like a good excuse inserted

e.g. "Glitching was not a viable attack because of REASON"

$ node ./explain.js "Your laptop is crashing because of REASON"
Your laptop is crashing because of a lack of shielding against alpha radiation (cosmic rays) in antenna
```


## Credits and References
* [gRPC docs](http://www.grpc.io/docs/)
* [gRPC Node](https://github.com/grpc/grpc/tree/release-0_13/src/node)
* [Hardware Excuse Generator](http://natashenka.ca/hardware-excuse-generator/)
* [excusegen - GitHub](https://github.com/natashenka/excusegen)
