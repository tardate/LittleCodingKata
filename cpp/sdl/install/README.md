# SDL2 MacOSX Install

Installing the Simple DirectMedia Layer library on MacOSX, and running a basic verification program in C++.

## Notes

SDL is written in C, works natively with C++, and there are bindings available for several other languages, including C# and Python.

### Installation with brew

There's a brew formula for SDL, so perhaps the easiest way to get going ...

```
$ brew install sdl2
$ brew info sdl2
sdl2: stable 2.0.14, HEAD
Low-level access to audio, keyboard, mouse, joystick, and graphics
https://www.libsdl.org/
/usr/local/Cellar/sdl2/2.0.12_1 (89 files, 4.7MB) *
  Poured from bottle on 2020-10-12 at 14:03:05
From: https://github.com/Homebrew/homebrew-core/blob/HEAD/Formula/sdl2.rb
License: Zlib
==> Options
--HEAD
  Install HEAD version
==> Analytics
install: 70,184 (30 days), 249,763 (90 days), 961,050 (365 days)
install-on-request: 6,615 (30 days), 23,753 (90 days), 96,341 (365 days)
build-error: 0 (30 days)
```

### Running the Example

See [example.cpp](./example.cpp) for details.
It links with the SDL library and uses a few informational APIs to get basic verification things are working.

A makefile compiles and runs the examples:

```
$ make
c++ -std=c++17 -Wall -O3 `sdl2-config --cflags --libs`    example.cpp   -o example
./example;
## SDL LIBRARY INFO
SDL compiled version 2.0.12
SDL linked version 2.0.12
## RENDER DRIVERS
Renderer                Name   Flags    max_texture_width   max_texture_height
       0               metal       e                    0                    0
       1              opengl       e                    0                    0
       2           opengles2       e                    0                    0
       3            software       9                    0                    0
```

## Credits and References

* [libsdl](https://www.libsdl.org/)
* [sdl2 brew formula](https://formulae.brew.sh/formula/sdl2)
