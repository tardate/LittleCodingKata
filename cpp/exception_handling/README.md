# #012 C++/exception_handling

Exercising C++ exception handling.

## Notes

The essentials of exception handling in c++:

* when compiling c++, exception handling is usually turned on by default. But this can be compiler-specific and require switches to enable
* mulitple `catch` blocks allow catching different types of errors
* [noexcept specifier](https://en.cppreference.com/w/cpp/language/noexcept_spec) indicates the method cannot throw an exception. Bad practice generally.
    * noexcept is an improved version of `throw()`, which is deprecated in C++11
* polymorphism applies: must catch exception subclasses before ancestors


## Demo

[exception_handling.cpp](./exception_handling.cpp) runs through a variety of exception classes that are caught:

* simple ints
* simple char messages
* string messages
* custom exception classes
* polymorphic standard exceptions

..and ends on an uncaught exception.

NB: this is updated for C++17 syntax - specifically the use of `noexcept` instead of `throw()`.

    $ g++ -std=c++17 -o exception_handling.exe exception_handling.cpp && ./exception_handling.exe

    Testing a range of standard and custom exceptions..

    Error code: 33
    Basic error message: Oh deary me
    String error message caught by reference: Out of bacon
    bad_alloc error message caught by reference: std::bad_alloc
    Generic exception error message caught by reference: std::exception
    CustomException message caught by reference: Something bad happened

    Now testing an exception in a constructor..

    exception_handling.exe(28207,0x7fffae28f380) malloc: *** mach_vm_map(size=1000000000000000) failed (error code=3)
    *** error: can't allocate region
    *** set a breakpoint in malloc_error_break to debug
    bad_alloc message: std::bad_alloc

    And we're still running!

    But the next has no handler:

    libc++abi.dylib: terminating with uncaught exception of type int
    Abort trap: 6


## Credits and References

* [noexcept specifier](https://en.cppreference.com/w/cpp/language/noexcept_spec)
* [Dynamic exception specification](https://en.cppreference.com/w/cpp/language/except_spec)
* [exception tutorial](http://www.cplusplus.com/doc/tutorial/exceptions/) - cplusplus.com
* [exception reference](http://www.cplusplus.com/reference/exception/exception/) - cplusplus.com
* [Learn Advanced C++ Programming](https://www.udemy.com/learn-advanced-c-programming/)
* [Doxygen documentation for the demo](https://codingkata.tardate.com/cpp/exception_handling/doc/html/)
