# #291 doxygen

Installing and testing doxygen for c++ source documentation generation on macOS.

## Compiling from Source (macOS)

```
$ git clone https://github.com/doxygen/doxygen.git
$ cd doxygen
$ mkdir build
$ cd build
$ cmake -G "Unix Makefiles" ..
$ make
```

All ran successfully (a few compiler warnings) and the executable is available
in `build/bin/doxygen`.


## Testing

For a quick test, I'm configuring and running doxygen on the [LCK: exception_handling](../exception_handling) example:

```
$ cd ../exception_handling
$ doxygen -g


Configuration file `Doxyfile' created.

Now edit the configuration file and enter

  doxygen Doxyfile

to generate the documentation for your project
```

I made only three changes to the default doxygen file:

```
PROJECT_NAME           = "LCK Exception Handling"
OUTPUT_DIRECTORY       = doc
GENERATE_LATEX         = NO
```

Then ran it:

```
$ doxygen Doxyfile
```
It generated the HTML documentation available [here](https://codingkata.tardate.com/cpp/exception_handling/doc/html)

[![hero_image](./assets/html_example.png?raw=true)](https://codingkata.tardate.com/cpp/exception_handling/doc/html)

## Credits and References
* [doxygen home](http://www.stack.nl/~dimitri/doxygen/index.html)
