# #149 drb

dRuby (drb) is a distributed object system for Ruby, included in the standard library.

## Notes

The dRuby (drb) distributed object system has been in the standard library since 1.8(??).

The standard library just includes the core drb framework.
The [full package](http://www2a.biglobe.ne.jp/~seki/ruby/druby.html)
includes a few more features, but seems to have never really made the transition to fully maintaned, standard-alone gem.

Actually, drb is a bit of a curiosity. It's main use appears to be for personal productivity gadgets
or simply research and exploration of distributed computing ideas.

The really nice thing is that it is super simple to get something working in a line or two of code..

Start the server...

    $ ./drb_server.rb
    TestServer
    starting on druby://localhost:9000..
    TestServer
    handling doit...


Make a client call...

    $ ./drb_client.rb
    Hello, Distributed World


![console](./assets/console.png?raw=true)

### Taking a Look at the Full Package

Downloading the latest(?) available source package:

    wget http://www2a.biglobe.ne.jp/~seki/ruby/drb-2.0.4.tar.gz
    tar zxvf drb-2.0.4.tar.gz
    rm drb-2.0.4.tar.gz


## Credits and References

* [druby](http://www2a.biglobe.ne.jp/~seki/ruby/druby.html) - original sources, full package from author Masatoshi SEKI
* [drb: Ruby Standard Library Documentation](https://ruby-doc.org/stdlib-2.7.2/libdoc/drb/rdoc/index.html)
* [rubysl-drb](https://rubygems.org/gems/rubysl-drb) - rubygems
* [rubysl-drb](https://github.com/jeremyvdw/rubysl-drb) - github
