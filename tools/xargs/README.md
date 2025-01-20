# #288 xargs

All about using xargs to build and execute command lines from standard input

## Notes

xargs is used to read tokens from the standard input, and convert these into arguments
it will pass to a command.

In this way it can be used to automate some operation based on data received from some source.
For example:

* deleting or otherwise manipulating files found with the `find` command
* act on specific items found in log files

With xargs, these tasks can be performed by chaining commands on the command line,
instead of writing a script to iterate over a collection of items.

The main concept to grok when it comes to xargs is how an input stream of tokens is parsed and passed to one or more command calls.
In essence:

* by default, all tokens (separated by blanks) from all input lines are passed as a single space-delimited string to the command
    * the -n parameter is used to limit the number of input tokens grouped together for each command call
    * the -L parameter is used to limit the number of input lines grouped together for each command call
* by default, the tokens are just appended to the command line of the call
    * but the -I parameter is used to replace occurrences of the specified pattern in the command arguments with the input lines or tokens

## examples

The [examples.sh](./examples.sh) script demonstrates some xargs capabilities:

    $ ./examples.sh

    # all these examples are given words.txt as input:
    embattle characteristic credit
    collect indication
    coin model wonder

    # example 1: by default, pass all input lines/tokens as params to the default command (echo)
    embattle characteristic credit collect indication coin model wonder

    # example 1b: adding --verbose echoes the command that xargs will run
    /bin/echo embattle characteristic credit collect indication coin model wonder
    embattle characteristic credit collect indication coin model wonder

    # example 1c: -n limits the number of tokens grouped for each invocation of the command. In this case -n 2:
    /bin/echo embattle characteristic
    embattle characteristic
    /bin/echo credit collect
    credit collect
    /bin/echo indication coin
    indication coin
    /bin/echo model wonder
    model wonder

    # example 1d: -L limits the number of lines used for each invocation of the command. In this case -L 2:
    /bin/echo embattle characteristic credit collect indication
    embattle characteristic credit collect indication
    /bin/echo coin model wonder
    coin model wonder

    # example 2: -I replaces occurrences of the specified pattern in the command arguments with input lines
    I got a word (embattle characteristic credit) to work with
    I got a word (collect indication) to work with
    I got a word (coin model wonder) to work with

    # example 2b: combining -n 1 with -I causes one commend to be run per token from the input
    I got a word (embattle) to work with
    I got a word (characteristic) to work with
    I got a word (credit) to work with
    I got a word (collect) to work with
    I got a word (indication) to work with
    I got a word (coin) to work with
    I got a word (model) to work with
    I got a word (wonder) to work with

    # example 3: xargs is an alternative to using a script to explicitly iterate over items e.g. with a for loop
    for loop: next item I got is embattle
    for loop: next item I got is characteristic
    for loop: next item I got is credit
    for loop: next item I got is collect
    for loop: next item I got is indication
    for loop: next item I got is coin
    for loop: next item I got is model
    for loop: next item I got is wonder

NB: <https://randomwordgenerator.com/> was used to used to generate [words.txt](words.txt)

## Credits and References

* [xargs man page](https://linux.die.net/man/1/xargs)
