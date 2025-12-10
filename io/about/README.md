# #393 About Io

A quick review of the Io language. It perhaps became most famous after earning a chapter in
Bruce Tate's [Seven Languages in Seven Weeks](../../books/seven-languages-in-seven-weeks/).

## Notes

The [Io language](https://iolanguage.org) is focused on expressiveness through simplicity.
It was created in 2002 by Steve Dekorte as a hobby/experimental language and was actively developed until 2008.
The build system is still maintained, and patches accepted, with the source on [GitHub](https://github.com/IoLanguage/io).

Io is:

* pure
    * minimal syntax
    * all values are objects
    * prototype-based object model
    * everything is a message, even assignment
    * no keywords, no globals
* dynamic
    * all messages are dynamic
    * code is a runtime modifiable tree of messages
    * arguments passed by expression, receiver controls eval
    * differential inheritance
    * become, transparent proxies, weak links
* concurrent
    * coroutine based actors
    * transparent futures
    * automatic lock detection

## Ubuntu Installation

The last release for macOS was for Intel, so there are no binaries compatible with modern Apple Silicon machines.
I'll do my test drive with Ubuntu (24.04.3 LTS) on Intel..

```sh
$ sudo apt update
$ sudo apt install alien build-essential libssl-dev libffi-dev libreadline-dev libncurses5-dev
$ wget https://iobin.suspended-chord.info/linux/iobin-linux-x64-rpm-current.zip
$ unzip iobin-linux-x64-rpm-current.zip
$ sudo alien --scripts IoLanguage-2013.11.05-Linux-x64.rpm
$ sudo dpkg -i iolanguage_2013.11.05-2_amd64.deb
Selecting previously unselected package iolanguage.
(Reading database ... 222438 files and directories currently installed.)
Preparing to unpack iolanguage_2013.11.05-2_amd64.deb ...
Unpacking iolanguage (2013.11.05-2) ...
Setting up iolanguage (2013.11.05-2) ...
```

Verifying we have a working binary installed:

```sh
$ io --version
Io Programming Language, v. 20110905
```

## A Quick Test Drive

Using the REPL to investigate some language features.
Let's make a [list](https://iolanguage.org/reference/index.html#Core.List) and call some methods:

```io
$ io
Io 20110905
Io> mylist := list(1, 2, 3, 4)
==> list(1, 2, 3, 4)
Io> mylist sum
==> 10
Io> mylist average
==> 2.5
```

### Objects

As a prototype language, new objects are created by cloning an existing object.
The prototype [Object](https://iolanguage.org/reference/index.html#Core.Object)  contains a clone slot that is a CFuntion that creates new objects.

The
[animals.io](./animals.io) script is a quick demonstration:

* creates a `hello` slot in the Animal base class for each animal to modify their characteristic "language"
* creates a `speak` method on Animal that prints the `hello` message of the object concerned (polymorphism)
* Cat and Dog animals created with their own version of `hello`
* creates a list containing a Cat and Dog
* iterate the list and get each animal to speak (virtual method invocation)

```io
Animal := Object clone
Animal hello := "???"
Animal speak := method(hello println)

Cat := Animal clone
Cat hello = "meow"

Dog := Animal clone
Dog hello = "woof"

pets := list(Cat, Dog)
pets foreach(speak)
```

Running the script:

```sh
$ io animals.io
meow
woof
```

### Concurrency

Io has outstanding concurrency support:
[threads](https://iolanguage.org/reference/index.html#Thread.Thread),
[coroutines](https://iolanguage.org/reference/index.html#Core.Coroutine),
actors, futures.

The [shakespeare.io](./shakespeare.io) example demonstrates coroutines:

* `yield` to another coroutine in the queue
* `@@` invokes a method asynchronously (without returning a future; `@` returns a future)
* `currentCoroutine` returns the currently running coroutine in Io state.
* `pause` removes coroutine from the queue and yields to another coroutine. System exit is executed if no coroutines left.

```io
cassius := Object clone
cassius speak := method(
    "Cassius: You wrong me every way; you wrong me, Brutus." println
    yield
    "Cassius: I am." println
    yield
)

brutus := Object clone
brutus reply := method(
    yield
    "Brutus: I said an elder soldier, not a better." println
    yield
    "Brutus: If you were better, you should know it." println
)

cassius @@speak; brutus @@reply

Coroutine currentCoroutine pause
```

Running the script:

```sh
$ io shakespeare.io
Cassius: You wrong me every way; you wrong me, Brutus.
Brutus: I said an elder soldier, not a better.
Cassius: I am.
Brutus: If you were better, you should know it.
Scheduler: nothing left to resume so we are exiting
  ---------
  Coroutine callStack                  A4_Exception.io 244
  Coroutine backTraceString            A4_Exception.io 274
  Coroutine showStack                  A4_Exception.io 177
  Coroutine pause                      Actor.io 150
  Object actorProcessQueue             Actor.io 115
```

## Credits and References

* <https://iolanguage.org/>
* <https://github.com/IoLanguage/io>
* <https://en.wikipedia.org/wiki/Io_(programming_language)>
