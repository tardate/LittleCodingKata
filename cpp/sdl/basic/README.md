# Basic SDL Graphics

Testing some basic windo and rendering functions with SDL library in C++.

## Notes

SDL lifecycle:

* [SDL_Init](http://wiki.libsdl.org/SDL_Init)
* [SDL_Quit](http://wiki.libsdl.org/SDL_Quit)

Window management:

* [SDL_CreateWindow](http://wiki.libsdl.org/SDL_CreateWindow)
* [SDL_DestroyWindow](http://wiki.libsdl.org/SDL_DestroyWindow)

Events

* [SDL_PollEvent](http://wiki.libsdl.org/SDL_PollEvent)
  * returns [SDL_Event](http://wiki.libsdl.org/SDL_Event) - union of all event structures used in SDL

Rendering

* [SDL_CreateRenderer](http://wiki.libsdl.org/SDL_CreateRenderer) - does the drawing
* [SDL_CreateTexture](http://wiki.libsdl.org/SDL_CreateTexture) -
* [SDL_UpdateTexture](http://wiki.libsdl.org/SDL_UpdateTexture) -

### Running the Example

See [example.cpp](./example.cpp) for details.
It links with the SDL library and uses a few informational APIs to get basic verification things are working.

A makefile compiles and runs the examples:

```
$ make
c++ -std=c++17 -Wall -O3 `sdl2-config --cflags --libs`    example.cpp   -o example
./example;

```

It generates an "abstract image":

![screenshot](./assets/screenshot.png?raw=true)

## Credits and References

* [libsdl](https://www.libsdl.org/)
