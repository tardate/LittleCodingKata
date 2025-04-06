# #208 Building MicroPython on macOS

Quick notes on my first experience building MicroPython on macOS.

## Notes

I first heard about MicroPython from the [kickstarter](http://www.kickstarter.com/projects/214379695/micro-python-python-for-microcontrollers)
campaign to open source the software.

MicroPython is basically Python cut down and enhanced for specifics that make it possible and worthwhile to run on microcontrollers.

But it can also run on host systems .. which is what I'm testing here. Building to run on macOS..

### Compiling from Source

Grabbing the latest from GitHub..

```sh
$ git clone git@github.com:micropython/micropython.git
$ cd micropython
$ git submodule update --init
$ git describe
v1.9.2-123-gbdc6e86
```

I'm building the unix port, which should be suitable for macOS.

```sh
cd ports/unix
```

Two steps: `make axtls` and `make`...

```sh
$ make axtls
... [lots of stuff clipped] ...
cp ../../lib/axtls/_stage/libaxtls.a build/libaxtls.a
```

Good. But now first attempt at make fails...

```sh
$ make
Use make V=1 or set BUILD_VERBOSE in your environment to increase build verbosity.
Package libffi was not found in the pkg-config search path.
Perhaps you should add the directory containing `libffi.pc'
to the PKG_CONFIG_PATH environment variable
No package 'libffi' found
Package libffi was not found in the pkg-config search path.
Perhaps you should add the directory containing `libffi.pc'
to the PKG_CONFIG_PATH environment variable
No package 'libffi' found
mkdir -p build/genhdr
Generating build/genhdr/mpversion.h
GEN build/genhdr/qstr.i.last
modffi.c:32:10: fatal error: 'ffi.h' file not found
#include <ffi.h>
         ^
1 error generated.
make: *** [build/genhdr/qstr.i.last] Error 1
make: *** Deleting file `build/genhdr/qstr.i.last'
```

But I have libffi installed with brew...

```sh
$ brew info libffi
libffi: stable 3.2.1 (bottled), HEAD [keg-only]
Portable Foreign Function Interface library
https://sourceware.org/libffi/
/usr/local/Cellar/libffi/3.0.13 (14 files, 356.2KB)
  Poured from bottle on 2014-02-22 at 20:19:38
From: https://github.com/Homebrew/homebrew-core/blob/master/Formula/libffi.rb
==> Caveats
This formula is keg-only, which means it was not symlinked into /usr/local,
because some formulae require a newer version of libffi.
```

So retrying with libffi package config:

```sh
$ PKG_CONFIG_PATH=/usr/local/opt/libffi/lib/pkgconfig make
... [lots of stuff clipped] ...
CC ../../py/../extmod/modussl_axtls.c
LINK micropython
__TEXT  __DATA  __OBJC  others  dec hex
6 0 0 0 6 6 build/build/frozen.o
2069  6942  0 0 9011  2333  build/build/frozen_mpy.o
307200  57344 0 4294998244  4295362788  1000608e4 micropython
```

Done. Now does it work??

```sh
$ ./micropython
MicroPython v1.9.2-123-gbdc6e86 on 2017-09-26; darwin version
Use Ctrl-D to exit, Ctrl-E for paste mode
>>> 3 + 3
6
>>>
```

Yes!

Not much more excitement to be had here. Really needs to be used with a microcontroller...
see my projects for that on [LEAP](http://leap.tardate.com)

## Credits and References

* [official site](http://www.micropython.org/)
* [micropython](https://github.com/micropython/micropython) - GitHub
* [kickstarter](http://www.kickstarter.com/projects/214379695/micro-python-python-for-microcontrollers)
