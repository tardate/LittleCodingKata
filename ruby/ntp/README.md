# NTP with Ruby

All about the NTP protocol with examples in ruby.

## Notes

The [Network Time Protocol](https://en.wikipedia.org/wiki/Network_Time_Protocol)

### The Protocol

[RFC5905](https://www.rfc-editor.org/rfc/rfc5905) defines Network Time Protocol Version 4.
The specification covers the roles of

* primary server - synchronized to a reference clock
* secondary server - has one or more upstream servers and one or more downstream servers or clients
* client - synchronizes to one or more upstream servers

Simple Network Time Protocol (SNTP) is a subset of NTP.
RFC5905 incorporates and obsoletes [SNTP RFC4330](https://www.rfc-editor.org/rfc/rfc4330).
SNTP simplified access paradigm for servers and clients using current and previous versions of NTP and SNTP.

#### SNTP Unicast Mode

In unicast mode, the client sends a request (NTP mode 3) to a
designated unicast server and expects a reply (NTP mode 4) from that server.
Communications are UDP, and the conventional ntp port is 123.

|Field Name           |  Request    | Reply                | Note |
|---------------------|-------------|----------------------|------|
|LI                   |  0          | 0-3                  | Leap Indicator
|VN                   |  1-4        | copied from  request | Version Number
|Mode                 |  3          | 4                    | protocol mode. 3=client, 4=server |
|Stratum              |  0          | 0-15                 | |
|Poll                 |  0          | ignore               | |
|Precision            |  0          | ignore               | |
|Root Delay           |  0          | ignore               | |
|Root Dispersion      |  0          | ignore               | |
|Reference Identifier |  0          | ignore               | |
|Reference Timestamp  |  0          | ignore               | |
|Originate Timestamp  |  0          | nonzero              | |
|Receive Timestamp    |  0          | nonzero              | |
|Transmit Timestamp   |  nonzero    | nonzero              | |
|Authenticator        |  optional   | optional             | |

* Originate Timestamp: This is the time at which the request departed the client for the server, in 64-bit timestamp format.
* Receive Timestamp: This is the time at which the request arrived at the server or the reply arrived at the client, in 64-bit timestamp format.
* Transmit Timestamp: This is the time at which the request departed the client or the reply departed the server, in 64-bit timestamp format.

Timestamp format:

                        1                   2                   3
    0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1
    +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
    |                           Seconds                             |
    +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
    |                  Seconds Fraction (0-padded)                  |
    +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+

#### Authentication?

The original protocol is not secure.

The NTPv3 defined a symmetric key authentication scheme for information purposes only.
NTPv4 introduced an Autokey public key authentication described in [RFC5906](https://www.rfc-editor.org/rfc/rfc5906).

Network Time Security (NTS) is a secure version of NTP[7] with TLS and AEAD.

### NTP Servers

[NTP Pool Project](https://www.ntppool.org/en/)
is a big virtual cluster of timeservers providing reliable easy to use NTP service for millions of clients.

See also:

* [NIST Internet Time Servers](https://tf.nist.gov/tf-cgi/servers.cgi)

### Using the net-ntp gem

The [net-ntp](https://github.com/zencoder/net-ntp) gem is a nice ruby wrapper for the ntp protocol.

See [example.rb](./example.rb) for a simple example of use.

    $ bundle exec ./example.rb
    Time is: 2022-11-13 12:13:37 +0800

    NTP response details:
    host: us.pool.ntp.org
    mode: server
    version: 3
    leap_indicator: no warning
    poll_interval: 0
    precision: -29
    root_delay: 0.003509521484375
    root_dispersion: 0
    reference_timestamp: 1668312814.1808853
    originate_timestamp: 1668312816.8865314
    receive_timestamp: 1668312817.0089016
    transmit_timestamp: 1668312817.008914
    offset: 0.017406582832336426
    stratum: 2 - secondary reference (via NTP or SNTP)
    reference_clock_identifier: 64.142.122.38
    reference_clock_identifier_text:

Note that as of now, only [net-ntp 2.1.3 is on rubygems](https://rubygems.org/gems/net-ntp).
This version has a bug when decoding stratum 1 server `reference_clock_identifier` details.
This is fixed in 2.1.4 that can be installed directly from github

64.142.122.38:

    $ bundle exec ./example.rb 64.142.122.38
    Time is: 2022-11-13 12:14:05 +0800

    NTP response details:
    host: 64.142.122.38
    mode: server
    version: 3
    leap_indicator: no warning
    poll_interval: 0
    precision: -17
    root_delay: 0.0
    root_dispersion: 0
    reference_timestamp: 1668312836.5694447
    originate_timestamp: 1668312845.8848696
    receive_timestamp: 1668312845.1554418
    transmit_timestamp: 1668312845.1556654
    offset: -0.408372163772583
    stratum: 1 - primary reference (e.g., radio clock)
    reference_clock_identifier: PPS
    reference_clock_identifier_text: atomic clock or other pulse-per-second source individually calibrated to national standards

time-a-g.nist.gov

    $ bundle exec ./example.rb time-a-g.nist.gov
    Time is: 2022-11-13 12:12:31 +0800

    NTP response details:
    host: time-a-g.nist.gov
    mode: server
    version: 3
    leap_indicator: no warning
    poll_interval: 13
    precision: -28
    root_delay: 0.000244140625
    root_dispersion: 0
    reference_timestamp: 1668312704.0
    originate_timestamp: 1668312751.887413
    receive_timestamp: 1668312751.4827232
    transmit_timestamp: 1668312751.4827247
    offset: -0.32253408432006836
    stratum: 1 - primary reference (e.g., radio clock)
    reference_clock_identifier: NIST
    reference_clock_identifier_text:

time.nist.gov:

    $ bundle exec ./example.rb time.nist.gov
    Time is: 2024-01-20 11:15:47 +0800

    NTP response details:
    host: time.nist.gov
    mode: server
    version: 3
    leap_indicator: no warning
    poll_interval: 13
    precision: -28
    root_delay: 0.000244140625
    root_dispersion: 0
    reference_timestamp: 1705720448.0
    originate_timestamp: 1705720546.582
    receive_timestamp: 1705720547.0944347
    transmit_timestamp: 1705720547.0944366
    offset: 0.21082615852355957
    stratum: 1 - primary reference (e.g., radio clock)
    reference_clock_identifier: NIST
    reference_clock_identifier_text:

sg.pool.ntp.org:

    $ bundle exec ./example.rb sg.pool.ntp.org
    Time is: 2022-11-13 12:12:32 +0800

    NTP response details:
    host: sg.pool.ntp.org
    mode: server
    version: 3
    leap_indicator: no warning
    poll_interval: 3
    precision: -23
    root_delay: 0.0119171142578125
    root_dispersion: 0
    reference_timestamp: 1668311883.194149
    originate_timestamp: 1668312752.887426
    receive_timestamp: 1668312752.3689647
    transmit_timestamp: 1668312752.3690267
    offset: -0.2609066963195801
    stratum: 2 - secondary reference (via NTP or SNTP)
    reference_clock_identifier: 58.27.114.187
    reference_clock_identifier_text:

## Credits and References

* [NTP: The Network Time Protocol](https://www.ntp.org/) home of the Network Time Protocol project
* [Network Time Protocol](https://en.wikipedia.org/wiki/Network_Time_Protocol)
* [RFC5905](https://www.rfc-editor.org/rfc/rfc5905) Network Time Protocol Version 4
* [NTP Pool Project](https://www.ntppool.org/en/)
* [NIST Internet Time Servers](https://tf.nist.gov/tf-cgi/servers.cgi)
* [net-ntp](https://github.com/zencoder/net-ntp) - github
* [net-ntp](https://rubygems.org/gems/net-ntp) - rubygems
