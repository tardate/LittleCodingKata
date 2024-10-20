# #195 Redis

Redis basics and MacOS installation.

## Notes

Redis is:

* open source (BSD licensed)
* in-memory data store
* available for most platforms (client and server)

Redis can be used as:

* database
* cache
* message broker

Redis features:

* data structures such as strings, hashes, lists, sets, sorted sets
* built-in replication
* Lua scripting
* LRU eviction
* transactions
* configurable levels of on-disk persistence

## MacOS Installation with Brew

Installing with brew and the [redis Homebrew formula](https://formulae.brew.sh/formula/redis):

```
$ brew install redis
..
$ brew info redis
redis: stable 5.0.7 (bottled), HEAD
Persistent key-value database, with built-in net interface
https://redis.io/
/usr/local/Cellar/redis/5.0.7 (13 files, 3.1MB) *
  Poured from bottle on 2020-01-09 at 10:07:22
From: https://github.com/Homebrew/homebrew-core/blob/master/Formula/redis.rb
==> Options
--HEAD
  Install HEAD version
==> Caveats
To restart redis after an upgrade:
  brew services restart redis
Or, if you don't want/need a background service you can just run:
  redis-server /usr/local/etc/redis.conf
==> Analytics
install: 44,051 (30 days), 109,494 (90 days), 482,890 (365 days)
install-on-request: 41,744 (30 days), 104,199 (90 days), 454,052 (365 days)
build-error: 0 (30 days)
```

## Testing with the CLI tools

Although one is normally interacting with redis using language specific clients, the
[redis-cli](https://redis.io/topics/rediscli) is a useful utility for the command line.

The ping command is used to test the ability to connect to a redis server:

```
$ redis-cli -v
redis-cli 5.0.7
$ redis-cli ping
PONG
$ redis-cli -h 127.0.0.1 -p 6379 ping
PONG
```

## Credits and References

* [redis.io](https://redis.io/) - home
* [redis](https://formulae.brew.sh/formula/redis) - Homebrew formula
* [redis-cli ](https://redis.io/topics/rediscli)
