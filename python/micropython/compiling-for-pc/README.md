# #208 Building MicroPython on macOS

Quick notes building MicroPython on desktop hardware. First tested with macOS/Intel, updated Jan-2026 with macOS on Apple Silicon and Ubuntu 24.04.

## Notes

I first heard about MicroPython from the [kickstarter](http://www.kickstarter.com/projects/214379695/micro-python-python-for-microcontrollers)
campaign to open source the software.

MicroPython is basically Python cut down and enhanced for specifics that make it possible and worthwhile to run on microcontrollers.

But it can also run on host systems .. which is what I'm testing here.

### Update Jan-2026

It's 2026 and I'm back to using MicroPython, and the notes below are updated accordingly.
My original notes used macOS on Intel, but I've now redone the tests with both macOS on Apple Silicon, and Ubuntu.

By happy coincidence, Matt Trentini was also just interviewed about
[MicroPython on the Agile Embedded Podcast](https://agileembeddedpodcast.com/episodes/micropython-with-matt-trentini). Well worth a listen.

### Compiling from Source

Grabbing the latest from GitHub..

```sh
$ git clone git@github.com:micropython/micropython.git
$ cd micropython
$ git submodule update --init
$ $ git describe
v1.27.0-64-gb87d73f2e
```

I'm building the unix port, which should be suitable for macOS.

```sh
cd ports/unix
```

First make submodules (this includes the cross-assembler)...

```sh
$ make -C ../../mpy-cross
...
LINK build/mpy-cross
__TEXT __DATA __OBJC others dec hex
409600 16384 0 4295032832 4295458816 100078000
$ make submodules
...
Submodule path 'lib/berkeley-db-1.xx': checked out '0f3bb6947c2f57233916dccd7bb425d7bf86e5a6'
Submodule path 'lib/mbedtls': checked out '107ea89daaefb9867ea9121002fbbdf926780e98'
Submodule path 'lib/micropython-lib': checked out '6ae440a8a144233e6e703f6759b7e7a0afaa37a4'
```

Good. Now build MicroPython itself:

```sh
$ make
...
LINK build-standard/micropython
__TEXT __DATA __OBJC others dec hex
540672 16384 0 4295081984 4295639040 1000a4000
```

Verify it is working; all good:

```sh
$ build-standard/micropython
MicroPython v1.28.0-preview.63.gb87d73f2e9.dirty on 2026-01-12; darwin [Clang 17.0.0] version
Type "help()" for more information.
>>> 3 + 3
6
>>>
```

Out of interest, lets see how well the test suite does here:

```sh
$ make test
...
967 tests performed (29492 individual testcases)
955 tests passed
111 tests skipped: ...
12 tests failed: basics/try_finally_break.py basics/try_finally_break2.py basics/try_finally_continue.py basics/try_finally_return2.py basics/try_finally_return3.py basics/try_finally_return4.py basics/try_finally_return5.py float/complex1.py float/math_fun.py float/math_fun_special.py extmod/select_poll_fd.py thread/stress_schedule.py
```

Pretty good, but it seems like there are some issues with the Unix port on macOS. Perhaps to be expected, as it is not the main development platform.

## MicroPython on Ubuntu

Specifically Ubuntu 24.04.3 LTS (GNU/Linux 6.8.0-90-generic x86_64)

Make sure dependencies are installed, then clone the MicroPython github repo:

```sh
$ sudo apt install build-essential git python3 pkg-config libffi-dev
...
$ git clone git@github.com:micropython/micropython.git
$ cd micropython
$ git describe
v1.27.0-64-gb87d73f2e
```

Select the folder for the unix port.

```sh
cd ports/unix
```

First make submodules (this includes the cross-assembler)...

```sh
$ make -C ../../mpy-cross
LINK build/mpy-cross
   text    data     bss     dec     hex filename
 409902   19656     880  430438   69166 build/mpy-cross
$ make submodules
...
Submodule path 'lib/berkeley-db-1.xx': checked out '0f3bb6947c2f57233916dccd7bb425d7bf86e5a6'
Submodule path 'lib/mbedtls': checked out '107ea89daaefb9867ea9121002fbbdf926780e98'
Submodule path 'lib/micropython-lib': checked out '6ae440a8a144233e6e703f6759b7e7a0afaa37a4'
```

Now build MicroPython itself:

```sh
$ make
...
LINK build-standard/micropython
   text    data     bss     dec     hex filename
 783062   70840    2960  856862   d131e build-standard/micropython
```

Verify it's working..

```sh
$ build-standard/micropython
MicroPython v1.28.0-preview.63.gb87d73f2e9 on 2026-01-12; linux [GCC 13.3.0] version
Type "help()" for more information.
>>> 3 + 3
6
>>>
```

Now let's check the test suite. All good:

```sh
$ make test
...
1020 tests performed (29927 individual testcases)
1020 tests passed
58 tests skipped: ...
```

## Conclusion

MicroPython is obviously more exciting with a microcontroller...
see my projects for that on <https://leap.tardate.com>.

But these test show that Ubuntu is a decent host for development of MicroPython itself,
or has a test bed for MicroPython projects with mocked or stubbed functionality.
It may be possible to do this on macOS also, but the tests indicate that one may expect to encounter macOS-specific issues in certain situations.

## Credits and References

* [official site](https://www.micropython.org/)
* <https://github.com/micropython/micropython>
* [kickstarter](<https://www.kickstarter.com/projects/214379695/micro-python-python-for-microcontrollers>
