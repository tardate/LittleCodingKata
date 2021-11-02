# About C++

My place for notes on C++ resources and references.

## Notes

Just a place for notes on C++ resources and references...

### Running on MacOS

Apple's XCode ships with their LLVM release and Clang.

    $ g++ --version
    Configured with: --prefix=/Applications/Xcode.app/Contents/Developer/usr --with-gxx-include-dir=/usr/include/c++/4.2.1
    Apple LLVM version 10.0.0 (clang-1000.11.45.5)
    Target: x86_64-apple-darwin17.7.0
    Thread model: posix
    InstalledDir: /Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin


Clang actually ships with two version of the standard library:

* Libc++, the LLVM/Clang's standard C++ library (default)
* Libstdc++, the GNU standard C++ library that comes standard in Linux (officially deprecated)

Compilation can select the library (and C++ version) with command line switches:

    g++ -std=c++17 -stdlib=libstdc++ ...
    g++ -std=c++17 -stdlib=libc++ ...


## Resources

* [Good list of C and C++ Standards References](https://en.cppreference.com/w/Cppreference:FAQ). Selected resources:
    * [The final draft standard C17 FDIS is available for free](http://www.open-std.org/jtc1/sc22/wg14/www/abq/c17_updated_proposed_fdis.pdf) [PDF]
    * [A C11 working draft n1570 (2011-04-12) is available for free and differs only minimally from the final C11 Standard](http://www.open-std.org/jtc1/sc22/wg14/www/docs/n1570.pdf) [PDF]
    * [The final draft of C++17 is n4659 (2017-03-21)](http://www.open-std.org/jtc1/sc22/wg21/docs/papers/2017/n4659.pdf) [PDF]
    * [A free C++11 Working Draft (n3337) is available](http://www.open-std.org/jtc1/sc22/wg21/docs/papers/2012/n3337.pdf) [PDF]
* [cppreference.com](https://en.cppreference.com/w/) - seems to most closely follow the specs
* [cplusplus.com](http://www.cplusplus.com/) - popular reference but seems not to have all the details from the specs
* [coliru](https://coliru.stacked-crooked.com/) - run C/C++ in a browser; bit like fiddler for Cxx
* [Toolchain versions in XCode](https://en.wikipedia.org/wiki/Xcode#10.x_series) - wikipedia
