# iperf/iperf3

iPerf is a tool for active measurements of the maximum achievable bandwidth on IP networks

## Notes

iPerf3 is a tool for active measurements of the maximum achievable bandwidth on IP networks. It supports tuning of various parameters related to timing, buffers and protocols (TCP, UDP, SCTP with IPv4 and IPv6). For each test it reports the bandwidth, loss, and other parameters. This is a new implementation that shares no code with the original iPerf and also is not backwards compatible. iPerf was orginally developed by NLANR/DAST. iPerf3 is principally developed by ESnet / Lawrence Berkeley National Laboratory. It is released under a three-clause BSD license.


## iPerf3

Newer version, supports MacOS Mojave ad later.

### MacOS Installation

Homebrew is perhaps the easiest:

```
$ brew install iperf3
...

$ iperf3 -v
iperf 3.10 (cJSON 1.7.13)
Darwin labarrossa-3.local 17.7.0 Darwin Kernel Version 17.7.0: Fri Oct 30 13:34:27 PDT 2020; root:xnu-4570.71.82.8~1/RELEASE_X86_64 x86_64
Optional features available: sendfile / zerocopy, authentication
```

### Running a local-to-local speed test (iperf3)

Start up the server in one terminal window:

```
$ iperf3 -s
-----------------------------------------------------------
Server listening on 5201 (test #1)
-----------------------------------------------------------
Accepted connection from ::1, port 59292
warning: Block size 16312 > sending socket buffer size 9216
Increasing socket buffer size to 17336
[  5] local ::1 port 5201 connected to ::1 port 55147
[ ID] Interval           Transfer     Bitrate         Jitter    Lost/Total Datagrams
[  5]   0.00-1.00   sec   143 KBytes  1.17 Mbits/sec  0.005 ms  0/9 (0%)
[  5]   1.00-2.00   sec   127 KBytes  1.04 Mbits/sec  0.006 ms  0/8 (0%)
[  5]   2.00-3.00   sec   127 KBytes  1.04 Mbits/sec  0.006 ms  0/8 (0%)
[  5]   3.00-4.00   sec   127 KBytes  1.04 Mbits/sec  0.008 ms  0/8 (0%)
[  5]   4.00-5.00   sec   127 KBytes  1.05 Mbits/sec  0.007 ms  0/8 (0%)
[  5]   5.00-6.00   sec   127 KBytes  1.04 Mbits/sec  0.008 ms  0/8 (0%)
[  5]   6.00-7.00   sec   127 KBytes  1.05 Mbits/sec  0.017 ms  0/8 (0%)
[  5]   7.00-8.00   sec   127 KBytes  1.04 Mbits/sec  0.017 ms  0/8 (0%)
[  5]   8.00-9.00   sec   127 KBytes  1.04 Mbits/sec  0.012 ms  0/8 (0%)
[  5]   9.00-10.00  sec   127 KBytes  1.05 Mbits/sec  0.009 ms  0/8 (0%)
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Jitter    Lost/Total Datagrams
[  5]   0.00-10.00  sec  1.26 MBytes  1.06 Mbits/sec  0.009 ms  0/81 (0%)  receiver
-----------------------------------------------------------
Server listening on 5201 (test #2)
-----------------------------------------------------------


```

Then run a test form another window:

```
$ iperf3 -u -c localhost
Connecting to host localhost, port 5201
warning: Block size 16312 > sending socket buffer size 9216
Increasing socket buffer size to 17336
[  8] local ::1 port 55147 connected to ::1 port 5201
[ ID] Interval           Transfer     Bitrate         Total Datagrams
[  8]   0.00-1.00   sec   143 KBytes  1.17 Mbits/sec  9
[  8]   1.00-2.00   sec   127 KBytes  1.04 Mbits/sec  8
[  8]   2.00-3.00   sec   127 KBytes  1.04 Mbits/sec  8
[  8]   3.00-4.00   sec   127 KBytes  1.04 Mbits/sec  8
[  8]   4.00-5.00   sec   127 KBytes  1.04 Mbits/sec  8
[  8]   5.00-6.00   sec   127 KBytes  1.04 Mbits/sec  8
[  8]   6.00-7.00   sec   127 KBytes  1.04 Mbits/sec  8
[  8]   7.00-8.00   sec   127 KBytes  1.04 Mbits/sec  8
[  8]   8.00-9.00   sec   127 KBytes  1.04 Mbits/sec  8
[  8]   9.00-10.00  sec   127 KBytes  1.04 Mbits/sec  8
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Jitter    Lost/Total Datagrams
[  8]   0.00-10.00  sec  1.26 MBytes  1.06 Mbits/sec  0.000 ms  0/81 (0%)  sender
[  8]   0.00-10.00  sec  1.26 MBytes  1.06 Mbits/sec  0.009 ms  0/81 (0%)  receiver

iperf Done.

```

## iPerf

Example with the earlier version, has support all the way back to MacOS Sierra.

### MacOS Installation

Homebrew is perhaps the easiest:

```
$ brew install iperf
...
$ brew info iperf
iperf: stable 2.0.13 (bottled)
Tool to measure maximum TCP and UDP bandwidth
https://sourceforge.net/projects/iperf2/
/usr/local/Cellar/iperf/2.0.13 (8 files, 135.7KB) *
  Poured from bottle on 2020-01-09 at 10:52:26
From: https://github.com/Homebrew/homebrew-core/blob/HEAD/Formula/iperf.rb
==> Analytics
install: 1,512 (30 days), 5,038 (90 days), 28,851 (365 days)
install-on-request: 1,509 (30 days), 5,031 (90 days), 28,598 (365 days)
build-error: 0 (30 days)
```

After installation:

```
$ iperf -v
iperf version 2.0.13 (21 Jan 2019) pthreads
```

### Running a local-to-local speed test (iperf 2)

Start up the server in one terminal window:

```
$ iperf -s -u
------------------------------------------------------------
Server listening on UDP port 5001
Receiving 1470 byte datagrams
UDP buffer size:  192 KByte (default)
------------------------------------------------------------
[  3] local 127.0.0.1 port 5001 connected with 127.0.0.1 port 61595
[ ID] Interval       Transfer     Bandwidth        Jitter   Lost/Total Datagrams
[  3]  0.0-10.0 sec  1.25 MBytes  1.05 Mbits/sec   0.031 ms    0/  892 (0%)

```

Then run a test form another window:

```
$ iperf -u -c localhost
------------------------------------------------------------
Client connecting to localhost, UDP port 5001
Sending 1470 byte datagrams, IPG target: 11215.21 us (kalman adjust)
UDP buffer size: 9.00 KByte (default)
------------------------------------------------------------
[  5] local 127.0.0.1 port 61595 connected with 127.0.0.1 port 5001
[ ID] Interval       Transfer     Bandwidth
[  5]  0.0-10.0 sec  1.25 MBytes  1.05 Mbits/sec
[  5] Sent 892 datagrams
[  5] Server Report:
[  5]  0.0-10.0 sec  1.25 MBytes  1.05 Mbits/sec   0.031 ms    0/  892 (0%)
```

## Credits and References

* [iperf/iperf3](https://iperf.fr/)
* [iperf Homebrew Formulae](https://formulae.brew.sh/formula/iperf)
* [iperf3 Homebrew Formulae](https://formulae.brew.sh/formula/iperf3)
