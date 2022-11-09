# IPv4 Addresses with Ruby

All about dissecting IPv4 addresses with ruby including networks, netmasks and CIDR

## Notes

IP addresses are understood for routing purposes according to the
[Classless Inter-Domain Routing (CIDR)](https://en.wikipedia.org/wiki/Classless_Inter-Domain_Routing)
strategy as specified in
[RFC1519](https://datatracker.ietf.org/doc/html/rfc1519).

While this also applies to IPv6 addresses, I'll just consider IPv4 addresses here.

### CIDR with IPv4

A given IPv4 addresses (e.g. `12.13.14.15`) has two parts:

* network prefix: defined by the most significant bits. This identifies a whole network or subnet.
* host identifier: defined by the least significant bits. This specifies a particular interface of a host on that network.

The subnet mask defines the boundary between network prefix and host identifier.

For example:

* `198.51.100.14/24` is CIDR notation meaning
    * IP address = `198.51.100.14`
    * and 24 bits of network prefix
* 24 bits of network prefix is ofter written as the equivalent subnet netmask `255.255.255.0`
* that leaves 8 bits for host identifiers within the network
    * i.e. 256 host identifiers / IP addresses
* the first IP in the network is sometimes referred to as the "network address"
    * i.e. `198.51.100.0` in this case
* the last IP in the network is used as a broadcast address for the network
    * i.e. `198.51.100.255` in this case
* that leaves 254 addresses to actually be used for host interfaces in the network

The [Subnet Calculator](https://mxtoolbox.com/subnetcalculator.aspx) site is an easy way to test/check IP addresses

### Dissecting an IPv4 Address with Ruby

The [IPAddr](https://ruby-doc.org/stdlib-2.5.1/libdoc/ipaddr/rdoc/IPAddr.html) standard library
provides the basic tools for dissecting and IPv4 address (with a bit of finagling).

The [ipv4info.rb](./ipv4info.rb) script provides an example of how to parse and use an IPv4 address.
Some example runs..

Given a network address and CIDR mask, it correctly extracts the network and host information:

    $ ./ipv4info.rb 198.51.100.14/24
    Given: 198.51.100.14/24, inspected using the IPAddr stdlib..

                   IPv4? : true
                Private? : false
                    CIDR : 24
             Subnet mask : 255.255.255.0
         Network address : 198.51.100.0
    Addresses in network : 256
        Hosts in network : 254

It recognises private (unquotable) addresses:

    $ ./ipv4info.rb 192.168.10.10/28
    Given: 192.168.10.10/28, inspected using the IPAddr stdlib..

                   IPv4? : true
                Private? : true
                    CIDR : 28
             Subnet mask : 255.255.255.240
         Network address : 192.168.10.0
    Addresses in network : 16
        Hosts in network : 14

Adjusting the CIDR mask resizes the network accordingly:

    $ ./ipv4info.rb 192.168.10.10/30
    Given: 192.168.10.10/30, inspected using the IPAddr stdlib..

                   IPv4? : true
                Private? : true
                    CIDR : 30
             Subnet mask : 255.255.255.252
         Network address : 192.168.10.8
    Addresses in network : 4
        Hosts in network : 2

And if no CIDR mask is provided, the address is treated as a "network of 1 host":

    $ ./ipv4info.rb 192.168.10.10
    Given: 192.168.10.10, inspected using the IPAddr stdlib..

                   IPv4? : true
                Private? : true
                    CIDR : 32
             Subnet mask : 255.255.255.255
         Network address : 192.168.10.10
    Addresses in network : 1
        Hosts in network : 1

PS: there's a test suite for the script:

    $ ./test_ipv4info.rb
    Run options: --seed 51973

    # Running:

    .....................

    Finished in 0.002686s, 7818.3173 runs/s, 7818.3173 assertions/s.

    21 runs, 21 assertions, 0 failures, 0 errors, 0 skips

### netaddr gem

The IPAddr library has some limitations:

* netmask is not directly provided, but can be generated with IPAddr e.g. `IPAddr.new('255.255.255.255').mask(cidr).to_s`
* host and address counts are not directly provided, so need to be calculated

The [netaddr](https://rubygems.org/gems/netaddr) gem
is a Ruby library for performing calculations on IPv4 and IPv6 subnets.
It handles makes most of the IPAddr limitations, with the exception of the private address detection.

See [ipv4info_netaddr.rb](./ipv4info_netaddr.rb) for a rewrite of the script but using the netaddr gem.
It behaves the same, bu needs a bundle first to make sure the gem is installed:

    $ bundle install
    $ ./ipv4info_netaddr.rb 198.51.100.14/24
    Given: 198.51.100.14/24, inspected using the NetAddr gem:

                   IPv4? : true
                Private? : false
                    CIDR : 24
             Subnet mask : 255.255.255.0
         Network address : 198.51.100.0
    Addresses in network : 256
        Hosts in network : 254

PS: there's also a test suite:

    $ ./test_ipv4info_netaddr.rb
    Run options: --seed 6405

    # Running:

    .....................

    Finished in 0.002640s, 7954.5452 runs/s, 7954.5452 assertions/s.

    21 runs, 21 assertions, 0 failures, 0 errors, 0 skips

## Credits and References

* [Classless Inter-Domain Routing](https://en.wikipedia.org/wiki/Classless_Inter-Domain_Routing)
* [RFC1519](https://datatracker.ietf.org/doc/html/rfc1519)
* [IPAddr](https://ruby-doc.org/stdlib-2.5.1/libdoc/ipaddr/rdoc/IPAddr.html) - ruby stdlib
* [netaddr](https://rubygems.org/gems/netaddr) - A Ruby library for performing calculations on IPv4 and IPv6 subnets
* [Subnet Calculator](https://mxtoolbox.com/subnetcalculator.aspx)
