# #080 make

Notes on make and makefiles.

## Notes

Make is a tool which controls the generation of executables and other non-source files of a program from the program's source files.
Traditionally used for compiling code, but can also be used to automate common tasks.

[GNU Make](https://www.gnu.org/software/make/) is the standard implementation of Make for Linux and OS X.
Common alternatives include BSD Make, Microsoft nmake, and CMake.

### The Makefile

Makefiles comprise rules, macros that define the required process. Indent with TAB not spaces!

Rules have the following structure:

    target .. : prerequisites ..
            recipe
            ...

### Built-In Rules

Run `make -p` in a folder with no makefile to see the default rules.

See [Catalogue-of-Rules](https://www.gnu.org/software/make/manual/make.html#Catalogue-of-Rules)
Includes:

* Compiling C programs - n.o is made automatically from n.c with a recipe of the form ‘$(CC) $(CPPFLAGS) $(CFLAGS) -c’.
* Compiling C++ programs -n.o is made automatically from n.cc, n.cpp, or n.C with a recipe of the form ‘$(CXX) $(CPPFLAGS) $(CXXFLAGS) -c’.

### Implicit-Variables

Pre-defined variables available to make.
See [Implicit-Variables](https://www.gnu.org/software/make/manual/make.html#Implicit-Variables).
Includes:

* CC Program for compiling C programs; default ‘cc’.
* CXX Program for compiling C++ programs; default ‘g++’.
* CFLAGS Extra flags to give to the C compiler.
* CXXFLAGS Extra flags to give to the C++ compiler.
* LDFLAGS Extra flags to give to compilers when they are supposed to invoke the linker
* LDLIBS Library flags or names given to compilers when they are supposed to invoke the linker

### Internal Macros / Automatic Variables

See [Automatic Variables](https://www.gnu.org/software/make/manual/make.html#Automatic-Variables)
Includes:

| Macro | Description |
|-------|-------------|
| `$?`  | names of all the prerequisites that are newer than the target |
| `$@`  | file name of the target of the rule |
| `$*`  | stem with which an implicit rule matches  |
| `$%`  | target member name, when the target is an archive member |
| `$<`  | name of the first prerequisite |

### Special Target Names

See [Special-Targets](https://www.gnu.org/software/make/manual/make.html#Special-Targets).
Includes:

| Target      | Description |
|-------------|-------------|
| `.DEFAULT`  | default commands if no matching target  |
| `.IGNORE`   | ignore error codes, same as the -i option |
| `.PRECIOUS` | Files you specify for this target are not removed  |
| `.SILENT`   | do not echo commands, same as the -s option |
| `.SUFFIXES` | suffixes that are meaningful in suffixes rules |
| `.PHONY`    | targets that should be run unconditionally |

## Tricks

### Compiling c++ to .exe

The exe extension is very 'DOS/Windows' and make doesn't go out of its way for this to be easy with default implicit rules.
But it can be done relatively generically by defining the suitable `%.exe: %.cpp` rule. e.g.

    SOURCES := $(wildcard *.cpp)
    TARGETS := $(SOURCES:.cpp=.exe)

    .PHONY: all
    all: $(TARGETS)

    .PHONY: clean
    clean:
      rm -f $(TARGETS) *.o
      rm -fR *.dSYM

    %.exe: %.cpp
      $(LINK.cpp) $^ $(LOADLIBES) $(LDLIBS) -o $@

    .SUFFIXES: .exe

NB: `LOADLIBES` is a deprecated (but still supported) alternative to `LDLIBS`, [see the manual](https://www.gnu.org/software/make/manual/html_node/Implicit-Variables.html).

## Credits and References

* [Make](https://en.wikipedia.org/wiki/Make_(software)) - wikipedia
* [GNU Make](https://www.gnu.org/software/make/)
* [CMake](https://cmake.org/)
* [GNU Make Manual](https://www.gnu.org/software/make/manual/make.html)
* [GNU Make Tutorial](https://linuxhint.com/gnu-make-tutorial/)
* [C++ Makefile Tutorial](https://www.softwaretestinghelp.com/cpp-makefile-tutorial/)
* [Using make and writing Makefiles](https://www.cs.swarthmore.edu/~newhall/unixhelp/howto_makefiles.html)
