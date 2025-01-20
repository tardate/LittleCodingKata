# #215 zeromq on MacOS

Installing zeromq on MacOS

## Notes

### Using Homebrew

Installing with brew and the [zeromq homebrew formula](https://formulae.brew.sh/formula/zeromq)

```
$ brew install zeromq
$ brew info zeromq
zeromq: stable 4.3.2 (bottled), HEAD
High-performance, asynchronous messaging library
https://zeromq.org/
/usr/local/Cellar/zeromq/4.3.2 (80 files, 3.6MB) *
  Poured from bottle on 2020-02-01 at 15:51:37
From: https://github.com/Homebrew/homebrew-core/blob/master/Formula/zeromq.rb
==> Dependencies
Build: asciidoc ✘, pkg-config ✔, xmlto ✘
==> Options
--HEAD
  Install HEAD version
==> Analytics
install: 10,130 (30 days), 30,371 (90 days), 135,773 (365 days)
install-on-request: 2,968 (30 days), 8,803 (90 days), 40,788 (365 days)
build-error: 0 (30 days)
```

Checking the library is installed and can be found for compilation and linking:

```
$ pkg-config --cflags libzmq
-I/usr/local/Cellar/zeromq/4.3.2/include

$ pkg-config --libs libzmq
-L/usr/local/Cellar/zeromq/4.3.2/lib -lzmq
```

All good!


## Credits and References

* [zeromq Download](https://zeromq.org/download/)
* [zeromq homebrew formula](https://formulae.brew.sh/formula/zeromq)
