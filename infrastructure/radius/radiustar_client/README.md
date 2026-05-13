# #456 radiustar RADIUS Client

Testing the radiustar ruby gem, one of the few RADIUS client libraries. Finding bugs and patching it to get at least basic authentication working with FreeRADIUS server.

## Notes

While looking for RADIUS client libraries for Ruby, I found [radiustar](https://rubygems.org/gems/radiustar) and put it to the test.

Bottom line:

* it's now well out of date and not actively maintained since 2013.
* has some critical bugs - some of which I fix below to get a basic auth flow working

I'm posting my notes for completeness. This library is **NOT** recommended for use.

### FreeRADIUS Server

I'm testing radiustar against a docker-hosted version of FreeRADIUS Server:

```sh
$ docker ps
CONTAINER ID   IMAGE                                 COMMAND                  CREATED          STATUS          PORTS                                                             NAMES
b96f060db38d   freeradius/freeradius-server:latest   "/docker-entrypoint.…"   10 minutes ago   Up 10 minutes   0.0.0.0:1812-1813->1812-1813/udp, [::]:1812-1813->1812-1813/udp   freeradius
```

See [LCK#214 FreeRADIUS Server on macOS](../freeradius-server-macosx/) for more info.

### Dictionaries

We need the RADIUS dictionaries for radiustar to operate.

I have exported the FreeRADIUS dictionaries to [dictionaries/](./dictionaries/) as follows:

```sh
docker cp freeradius:/usr/share/freeradius ./dictionaries
```

### Testing Auth with radtest

To verify usernames, passwords and secrets are correct,
I am using the `radtest` script from FreeRADIUS docker image:

```sh
$ docker exec -it freeradius radtest testuser testpass 192.168.10.85 0 testing123-1
Sent Access-Request Id 239 from 0.0.0.0:55456 to 192.168.10.85:1812 length 78
 User-Name = "testuser"
 User-Password = "testpass"
 NAS-IP-Address = 172.17.0.2
 NAS-Port = 0
 Message-Authenticator = 0x00
 Cleartext-Password = "testpass"
Received Access-Accept Id 239 from 192.168.10.85:1812 to 172.17.0.2:55456 length 38
 Message-Authenticator = 0xe0410432312a1ea479d38c85a67d062a
```

### Running a Simple Auth Script

The [simple_auth.rb](./simple_auth.rb) script demonstrates a basic Auth-Request flow.

Note: the following is **after** fixing the bugs and issues with radiustar (see notes below investigation details and fixes.

Running the client:

```sh
$ ruby simple_auth.rb testuser testpass testing123-1
missing attribute for line: ["VALUE", "FreeDHCP-Opcode", "Client-Message", "1"]
missing attribute for line: ["VALUE", "FreeDHCP-Opcode", "Server-Message", "2"]
Sending Auth-Request to '127.0.0.1'..
Got reply: Access-Accept
$ ruby simple_auth.rb testuser badpass testing123-1
missing attribute for line: ["VALUE", "FreeDHCP-Opcode", "Client-Message", "1"]
missing attribute for line: ["VALUE", "FreeDHCP-Opcode", "Server-Message", "2"]
Sending Auth-Request to '127.0.0.1'..
Got reply: Access-Reject
```

tcp dump of the requests and responses:

```sh
$ sudo tcpdump -i lo0 -nn -s0 -X udp port 1812
...
21:01:01.729295 IP 127.0.0.1.51058 > 127.0.0.1.1812: RADIUS, Access-Request (1), id: 0xa5 length: 101
 0x0000:  4500 0081 7686 0000 4011 0000 7f00 0001  E...v...@.......
 0x0010:  7f00 0001 c772 0714 006d fe80 01a5 0065  .....r...m.....e
 0x0020:  6d2a 4871 4e52 317c e086 63eb 51c4 8dca  m*HqNR1|..c.Q...
 0x0030:  5012 19c8 7e96 9459 7e98 17be b7a1 d925  P...~..Y~......%
 0x0040:  4009 010a 7465 7374 7573 6572 200b 3132  @...testuser..12
 0x0050:  372e 302e 302e 3104 067f 0000 0102 12d3  7.0.0.1.........
 0x0060:  9bf9 92b5 65b7 1ecd afde 284b 0e05 5f08  ....e.....(K.._.
 0x0070:  067f 0000 0105 0600 0000 003d 0600 0000  ...........=....
 0x0080:  0f                                       .
21:01:01.732772 IP 127.0.0.1.1812 > 127.0.0.1.51058: RADIUS, Access-Accept (2), id: 0xa5 length: 38
 0x0000:  4500 0042 3d56 0000 4011 0000 7f00 0001  E..B=V..@.......
 0x0010:  7f00 0001 0714 c772 002e fe41 02a5 0026  .......r...A...&
 0x0020:  dd64 fb0d 36da 69dd 9834 c8f0 0d73 410a  .d..6.i..4...sA.
 0x0030:  5012 66e2 8b76 5678 e0a7 7475 b1e6 fda9  P.f..vVx..tu....
 0x0040:  9acb                                     ..
21:01:07.606802 IP 127.0.0.1.57019 > 127.0.0.1.1812: RADIUS, Access-Request (1), id: 0xad length: 101
 0x0000:  4500 0081 10a4 0000 4011 0000 7f00 0001  E.......@.......
 0x0010:  7f00 0001 debb 0714 006d fe80 01ad 0065  .........m.....e
 0x0020:  3377 7601 26be db37 39c2 1676 66bf 29f5  3wv.&..79..vf.).
 0x0030:  5012 d7ab 3317 a4c7 e7d9 baf2 14a9 f4e3  P...3...........
 0x0040:  e716 010a 7465 7374 7573 6572 200b 3132  ....testuser..12
 0x0050:  372e 302e 302e 3104 067f 0000 0102 1217  7.0.0.1.........
 0x0060:  0446 fa1f d037 aa2d 3fec 0ef3 62ca 3908  .F...7.-?...b.9.
 0x0070:  067f 0000 0105 0600 0000 003d 0600 0000  ...........=....
 0x0080:  0f                                       .
21:01:08.615876 IP 127.0.0.1.1812 > 127.0.0.1.57019: RADIUS, Access-Reject (3), id: 0xad length: 38
 0x0000:  4500 0042 8c8f 0000 4011 0000 7f00 0001  E..B....@.......
 0x0010:  7f00 0001 0714 debb 002e fe41 03ad 0026  ...........A...&
 0x0020:  c527 25bb 28fc 6b27 e1fe cb2a 369d f933  .'%.(.k'...*6..3
 0x0030:  5012 7415 dcff 929f 4efd 987f a185 a62a  P.t.....N......*
 0x0040:  80a5                                     ..
...
```

The abbreviated FreeRADIUS log of the interaction:

```sh
(23) Received Access-Request Id 165 from 192.168.65.1:34508 to 172.17.0.2:1812 length 101
(23)   Message-Authenticator = 0x19c87e9694597e9817beb7a1d9254009
(23)   User-Name = "testuser"
(23)   NAS-Identifier = "127.0.0.1"
(23)   NAS-IP-Address = 127.0.0.1
(23)   User-Password = "testpass"
(23)   Framed-IP-Address = 127.0.0.1
(23)   NAS-Port = 0
(23)   NAS-Port-Type = Ethernet
(23) ...
(23) Found Auth-Type = PAP
(23) ...
(23)   Auth-Type PAP {
(23) pap: Login attempt with password
(23) pap: Comparing with "known good" Cleartext-Password
(23) pap: User authenticated successfully
(23) ...
(23) Sent Access-Accept Id 165 from 172.17.0.2:1812 to 192.168.65.1:34508 length 38
(23) Finished request
(23) ...
(24) Received Access-Request Id 173 from 192.168.65.1:40002 to 172.17.0.2:1812 length 101
(24)   Message-Authenticator = 0xd7ab3317a4c7e7d9baf214a9f4e3e716
(24)   User-Name = "testuser"
(24)   NAS-Identifier = "127.0.0.1"
(24)   NAS-IP-Address = 127.0.0.1
(24)   User-Password = "badpass"
(24)   Framed-IP-Address = 127.0.0.1
(24)   NAS-Port = 0
(24)   NAS-Port-Type = Ethernet
(24) ...
(24) Found Auth-Type = PAP
(24) ...
(24)   Auth-Type PAP {
(24) pap: Login attempt with password
(24) pap: Comparing with "known good" Cleartext-Password
(24) pap: ERROR: Cleartext password does not match "known good" password
(24) pap: Passwords don't match
(24)     [pap] = reject
(24)   } # Auth-Type PAP = reject
(24) ...
(24) Sent Access-Reject Id 173 from 172.17.0.2:1812 to 192.168.65.1:40002 length 38
```

### radiustar Issues and Fixes

#### Fix 1: Gem dependencies

Running on Ruby 3.4.8 with latest gems, the `ipaddr_extensions` gem has a "silent" dependency on `scanf` that must also be installed.

Fixed this by adding `scanf to my [Gemfile](./Gemfile) and running`bundle install`.

#### Fix 2: Incomplete dictionaries

The FreeRADIUS dictionaries have two common issues:

* values defined for non-existent attributes
* attribute names with inconsistent case

Out of the box, radiustar crashes while loading dictionaries with errors like:

```sh
radiustar-0.0.8/lib/radiustar/dictionary.rb:119:in `set_value': undefined method `add_value' for nil:NilClass (NoMethodError)
```

My fix is to monkey-patch two critical `Dictionary` and `AttributesCollection` methods to handle the dictionaries nicely.
The patch is loaded from [patch-dictionary-loading.rb](./patch-dictionary-loading.rb):

```ruby
module Radiustar
  class Dictionary
    def set_value(line)
      @attributes.find_by_name(line[1]).add_value(line[2], line[3])
    rescue NoMethodError
      puts "missing attribute for line: #{line}"
    end
  end
  class AttributesCollection
    def find_by_name(name)
      @collection.find { |k, _| k.casecmp?(name) }&.last
    end
  end
end
```

#### Fix 3: Packet Encoding

Out of the box, radiustar was failing with attribute data overflow errors reported on the FreeRADIUS server e.g.:

```txt
Receive - Malformed RADIUS packet from host 192.168.65.1: attribute 141 data overflows the packet
Ready to process requests
```

These related to incorrect encoding of the `User-Password` attribute - a bug in the original `Radiustar::Packet#encode` method.

The fix was to monkey-patch the method. The patch is loaded from [patch-packet-encoding.rb](./patch-packet-encoding.rb):

```ruby
module Radiustar
  class Packet
    def encode(value, secret)
      raise "Authenticator must be 16 bytes" unless @authenticator.bytesize == 16

      # memo the shared secret for use in Message-Authenticator calculation
      @shared_secret = secret

      # pad password to multiple of 16 bytes
      padded = value.dup.b
      padded << "\x00" * ((16 - padded.bytesize % 16) % 16)

      result = +""
      previous = @authenticator

      padded.bytes.each_slice(16) do |slice|
        block = slice.pack('C*')

        hash = Digest::MD5.digest(secret + previous)

        encrypted =
          block.bytes.zip(hash.bytes).map { |a, b| a ^ b }.pack('C*')

        result << encrypted
        previous = encrypted
      end

      # puts "Encrypting password '#{value}' with secret '#{secret}' and authenticator '#{@authenticator.unpack1('H*')}' to '#{result.unpack1('H*')}'"
      result
    end
  end
end
```

#### Fix 4: Message Authentication

Out of the box, radiustar was not adding a valid message authenticator to the auth request.

Comparing the server logs, a valid request from radtest as a `Message-Authenticator` and correctly decodes the `User-Password`:

```txt
(13) Received Access-Request Id 255 from 127.0.0.1:44499 to 127.0.0.1:1812 length 78
(13)   Message-Authenticator = 0x1d0855abe1993e847d08eeab9c02495d
(13)   User-Name = "testuser"
(13)   User-Password = "testpass"
(13)   NAS-IP-Address = 172.17.0.2
(13)   NAS-Port = 0
```

A bad request from radiustar is missing a `Message-Authenticator` and so cannot correctly decode the `User-Password`:

```txt
(12) Received Access-Request Id 137 from 192.168.65.1:60976 to 172.17.0.2:1812 length 83
(12)   User-Name = "testuser"
(12)   NAS-Identifier = "127.0.0.1"
(12)   NAS-IP-Address = 127.0.0.1
(12)   User-Password = "\006\205jX3ȿ\363\256\304 \252\226\326Y\260"
(12)   Framed-IP-Address = 127.0.0.1
(12)   NAS-Port = 0
(12)   NAS-Port-Type = Ethernet
```

There are a few issues here:

* radiustar does not implement support for octets attribute type used by `Message-Authenticator`. Fixed by monkey-patching `Radiustar::Packet::Attribute#pack_attribute`.
* radiustar does not provide a way of adding the `Message-Authenticator`. Fixed by monkey-patching `Radiustar::Packet#gen_auth_authenticator`.
* radiustar does not provide a way of correctly calculating the `Message-Authenticator` value. Fixed by monkey-patching `Radiustar::Packet#pack`.

The patch is loaded from [patch-message-authentication.rb](./patch-message-authentication.rb):

```ruby

module Radiustar
  class Packet
    class Attribute
      alias_method :original_pack_attribute, :pack_attribute
      def pack_attribute attribute
        if attribute.type == "octets"
          anum = attribute.id
          val = @value
          [anum,
            val.length + 2,
            val
          ].pack(P_ATTR)
        else
          original_pack_attribute attribute
        end
      end
    end

    alias_method :original_gen_auth_authenticator, :gen_auth_authenticator
    def gen_auth_authenticator
      original_gen_auth_authenticator
      # use fixed authenticator for testing, should be random in real implementation
      # @authenticator = ["fa02f811e8aadf8cd786aee5188d6a29"].pack('H*')
      set_attribute('Message-Authenticator', @authenticator)
    end

    alias_method :original_pack, :pack
    def pack
      if @attributes.has_key? 'Message-Authenticator'
        @attributes['Message-Authenticator'].value = "\x00" * 16
        packed = original_pack
        ma = OpenSSL::HMAC.digest('md5', @shared_secret, packed)
        @attributes['Message-Authenticator'].value = ma
      end
      @packed = original_pack
      # puts "Packing packet with code '#{CODES[@code]}', id '#{@id}', authenticator '#{@authenticator.unpack1('H*')}' to '#{@packed.unpack1('H*')}'"
      @packed
    end
  end
end
```

### More Issues

These patches are enough to get a basic auth request working, but they are far from a complete fix for the radiustar gem. Minimum required:

* fix accounting calls
* revamp the API to better handle `shared_secret`
* general modernisation

Conclusion: this is not the RADIUS client library you are looking for.
Unfortunately I've yet to find a better one that has is currently maintained and works correctly.
The patches I've tried here might be the first step to revamping radiustar, but that's not a project I'm up for right now.

## Credits and References

* <https://github.com/pjdavis/radiustar>
* <https://rubygems.org/gems/radiustar>
