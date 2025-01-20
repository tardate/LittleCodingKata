# #071 Random MAC Addresses

Delving into MAC addresses and a little script to generate random ones.

## Notes

This is a quick ruby port of the [python/random_mac_generation](../../python/random_mac_generation/) example.
See there for notes on MAC addresses and such.

### A Little Random MAC Generator

[random_mac.rb](./random_mac.rb) generates a random MAC
using the Xensource, Inc. OUI by default unless you
pass it to a specific OUI on the command line:

```sh
$ ruby test_random_mac.rb
Run options: --seed 15492

# Running:

....

Finished in 0.001304s, 3067.4847 runs/s, 3834.3558 assertions/s.

4 runs, 5 assertions, 0 failures, 0 errors, 0 skips

$ ruby random_mac.rb
00-16-3e-73-45-fa
$ ruby random_mac.rb 11-22-33
11-22-33-7f-13-55
```

## Credits and References

* [MAC address](https://en.wikipedia.org/wiki/MAC_address) - wikipedia
* [Media access control](https://en.wikipedia.org/wiki/Media_access_control) - wikipedia
* [macgen.py](http://www.linux-kvm.com/sites/default/files/macgen.py) - the script that got me started
* [IEEE Registration Authority](https://regauth.standards.ieee.org/standards-ra-web/pub/view.html#registries) - including full registry download
