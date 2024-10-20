# #120 Century C

Notes on the book 21st Century C, 2nd Edition by Ben Klemens, pubished by O'Reilly

## Notes

See:

* [O'Reilly listing](https://learning.oreilly.com/library/view/21st-century-c/9781491904428/)
* [goodreads](https://www.goodreads.com/book/show/17017525-21st-century-c)
* [example code source](https://resources.oreilly.com/examples/0636920025108/)

## Highlights from the Table of Contents

* Preface
* C Is Punk Rock
* Q & A (Or, the Parameters of the Book)
* Standards: So Many to Choose From

### I. The Environment

#### 1. Set Yourself Up for Easy Compilation

* Use a Package Manager
* Compiling C with Windows
* Runtime Linking
* Using Makefiles
* Using Libraries from Source

Good practical introduction to setting up a working environment:

* compiler: gcc / clang
* debugger: gdb
* profiler: gprof
* make
* Valgrind, to test for C memory usage errors
* pkg-config, for finding libraries.
* Doxygen, for documentation generation
* A text editor

Later chapters cover: Autotools: Autoconf, Automake, libtool


#### 2. Debug, Test, Document

* Using a Debugger
* Using Valgrind to Check for Errors
* Unit Testing
* Error Checking
* Interweaving Documentation

#### 3. Packaging Your Project

Makefiles vs. Shell Scripts
Packaging Your Code with Autotools

#### 4. Version Control

Covers basics of git.

#### 5. Playing Nice with Others

* Dynamic Loading
* Python Host

### II. The Language

#### 6. Your Pal the Pointer

* Automatic, Static, and Manual Memory
* Persistent State Variables
* Pointers Without malloc

#### 7. Inessential C Syntax that Textbooks Spend a Lot of Time Covering

* Don’t Bother Explicitly Returning from main
* Let Declarations Flow
* Set Array Size at Runtime
* Cast Less
* Enums and Strings
* Labels, gotos, switches, and breaks
* Deprecate Float
* Comparing Unsigned Integers
* Safely Parse Strings to Numbers


#### 8. Important C Syntax that Textbooks Often Do Not Cover

* Cultivate Robust and Flourishing Macros
* Linkage with static and extern
* The const Keyword


#### 9. Easier Text Handling

* Making String Handling Less Painful with asprintf
* A Pæan to strtok
* Unicode

#### 10. Better Structures

* Compound Literals
* Variadic Macros
* Safely Terminated Lists
* Multiple Lists
* Foreach
* Vectorize a Function
* Designated Initializers
* Initialize Arrays and Structs with Zeros
* Typedefs Save the Day
* Return Multiple Items from a Function
* Flexible Function Inputs
* The Void Pointer and the Structures It Points To

#### 11. Object-Oriented Programming in C

Shows how to use OOP concenpts in C with a couple of full examples.

#### 12. Parallel Threads

* OpenMP
* Thread Local
* Shared Resources
* Pthreads
* C atoms

#### 13. Libraries

* GLib - libGlib
* POSIX
* The GNU Scientific Library - libGSL
* SQLite - libSQLite3
* libxml and cURL (libXML2, libcURL)

#### Epilogue

Provides a very good "C 101"

## Getting the Example Source

The git repo actually contains a ziped archive of the sources.
I've extracted locally to a folder called `example_source` as follows:

```
$ git clone https://resources.oreilly.com/examples/0636920025108.git
$ tar zxvf 0636920025108/21st_century_examples.tgz
$ mv 21st_century_examples example_source
$ rm -fR 0636920025108
```

## Credits and References

* [21st Century C](https://learning.oreilly.com/library/view/21st-century-c/9781491904428/) - O'Reilly listing
