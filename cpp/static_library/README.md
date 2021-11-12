# C++ Static Libraries

Basics of building and using static libraries with C++.

## Notes

Distributing code as static libraries for C++:

* library maker produces the binary library files with associated header files
* library user:
  * compiles the program with the library header files
  * links the program with the library binary files

The "static" reference means the library references are resolved at compile/link time, so the resulting executable has
includes the library built-in. i.e. no runtime dependency on the library binaries.

## Making the Library

The [animals](./animals) folder defines a simple library. It provides a "Cat" class that knows how to `speak()`.

The [Makefile](./demo/Makefile) is setup to generate a library file.
Basically, instead of targeting an executable like an actual program, we compile an link to a library archive file.
Since I am on MacOS, I'm using the [GCC archiver](https://en.wikipedia.org/wiki/Ar_(Unix))

    $ cd animals
    $ make
    c++ -std=c++17 -Wall -O3   -c -o cat.o cat.cpp
    ar -rsc libanimals.a cat.o

The library follows [Static Libraries](https://tldp.org/HOWTO/Program-Library-HOWTO/static-libraries.html) conventions:

    "lib" + library-name + ".a"

So given our library is called "animals", the library file is "libanimals.a"

NB: [Shared Libraries](https://tldp.org/HOWTO/Program-Library-HOWTO/shared-libraries.html) conventions:

    "lib" + library-name + ".so"


## Distributing the library

For others to use the library they need to things - the compiled library, and header files.
For this test, I'm simply going to "distribute" using `cp`(!) ...

    $ cp animals/libanimals.a demo/lcklib/
    $ cp animals/*.h demo/lcklib/include

NB: I've arbitrarily decided to put the binaries in a `lcklib` folder, and headers in `lcklib/include`.

## Using the Library

For client programs to use the library, they need two things:

* compiler needs to be told where to find the header files (`-I./lcklib/include`)
* the linker needs to be told where to find the binaries (`-L./lcklib`) and what libraries to link (`-lanimals`)

The [Makefile](./demo/Makefile) is setup to do that for us:

    $ cd demo
    $ make
    c++ -std=c++17 -Wall -O3 -I./lcklib/include   -c -o demo.o demo.cpp
    c++ -L./lcklib -lanimals  demo.o   -o demo
    ./demo
    Hello there!!!
    Meeeouwww!!!

## Credits and References

* [Static_library](https://en.wikipedia.org/wiki/Static_library) - wikipedia
* [Static and Dynamic Libraries](https://www.geeksforgeeks.org/static-vs-dynamic-libraries/) - geeksforgeeks
* [Walkthrough: Create and use a static library](https://docs.microsoft.com/en-us/cpp/build/walkthrough-creating-and-using-a-static-library-cpp?view=msvc-170)
* [ar (Unix)](https://en.wikipedia.org/wiki/Ar_(Unix))
* [Shared Libraries](https://tldp.org/HOWTO/Program-Library-HOWTO/shared-libraries.html)
* [Static Libraries](https://tldp.org/HOWTO/Program-Library-HOWTO/static-libraries.html)
