# #066 Random MAC Addresses

Delving into MAC addresses and a little script to generate random ones.

## About MAC Addresses

*A media access control address (MAC address), also called physical address, is a unique identifier assigned to network interfaces for communications on the physical network segment* ([wikipedia](https://en.wikipedia.org/wiki/MAC_address))

MAC-48 defines the familiar 48-bit sequence (00-16-3e-53-79-a8) that comprises two parts:
* 24 bit organisational identifier (OUI) that is assigned by the [IEEE Registration Authority](https://regauth.standards.ieee.org/standards-ra-web/pub/view.html#registries)
* 24 bit network interface controller (NIC) that is assigned by the manufacturer

MAC-48 is now subsumed within the EUI-48 scheme, which has more general application beyond network interfaces.
There is a 64-bit EUI-64 scheme which should be more future-proof, and is used with IPv6 for example.

There are specific MAC addresses and ranges reserved for
[multicast](https://en.wikipedia.org/wiki/Multicast_address#Ethernet)
and [broadcast](https://en.wikipedia.org/wiki/Broadcast_address#Ethernet).

## MAC in Ethernet

MAC source and destination addresses appear in the [Ethernet frame header](https://en.wikipedia.org/wiki/Ethernet_frame).

Conceptually, the [media access control](https://en.wikipedia.org/wiki/Media_access_control) layer
is the lower sublayer of the data link layer (layer 2) of the seven-layer [OSI model](https://en.wikipedia.org/wiki/OSI_model).

## A Little Random MAC Generator

[random_mac.py](./random_mac.py) generates a random MAC
using the Xensource, Inc. OUI by default unless you
pass it to a specific OUI on the command line:

```
$ python test_random_mac.py
....
----------------------------------------------------------------------
Ran 4 tests in 0.001s

OK
$ python random_mac.py
00-16-3e-53-79-a8
$ python random_mac.py 11-22-33
11-22-33-5c-74-54
```

## MAC Vendor Lookup

As well as the [IEEE Registration Authority](https://regauth.standards.ieee.org/standards-ra-web/pub/view.html#registries) itself,
there are any number of sites where youj can lookup official assigned numbers, including:

* [Wireshark OUI lookup tool](https://www.wireshark.org/tools/oui-lookup.html)
* [MACVendors](http://www.macvendors.com/)
* [Vendor/Ethernet/Bluetooth MAC Address Lookup and Search](http://www.coffer.com/mac_find/)

## Credits and References
* [MAC address](https://en.wikipedia.org/wiki/MAC_address) - wikipedia
* [Media access control](https://en.wikipedia.org/wiki/Media_access_control) - wikipedia
* [macgen.py](http://www.linux-kvm.com/sites/default/files/macgen.py) - the script that got me started
* [IEEE Registration Authority](https://regauth.standards.ieee.org/standards-ra-web/pub/view.html#registries) - including full registry download
