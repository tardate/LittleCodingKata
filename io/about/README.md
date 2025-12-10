# #xxx About Io

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
I'll do my test drive with Ubuntu on Intel..

Ubuntu 24.04.3 LTS
sudo apt install alien build-essential libssl-dev libffi-dev libreadline-dev libncurses5-dev

wget https://iobin.suspended-chord.info/linux/iobin-linux-x64-rpm-current.zip
unzip iobin-linux-x64-rpm-current.zip 
sudo alien --scripts IoLanguage-2013.11.05-Linux-x64.rpm
sudo dpkg -i iolanguage_2013.11.05-2_amd64.deb 
Selecting previously unselected package iolanguage.
(Reading database ... 222438 files and directories currently installed.)
Preparing to unpack iolanguage_2013.11.05-2_amd64.deb ...
Unpacking iolanguage (2013.11.05-2) ...
Setting up iolanguage (2013.11.05-2) ...
$ io --version
Io Programming Language, v. 20110905

## A Quick Test Drive

### Lists

$ io
Io 20110905
Io> mylist := list(1, 2, 3, 4)
==> list(1, 2, 3, 4)
Io> mylist sum
==> 10
Io> mylist average
==> 2.5

### Objects

$ io animals.io 
meow
woof


Io> Animal := Object clone
==>  Animal_0x3b5996b0:
  type             = "Animal"

Io> Animal speak := "..."     
==> ...
Io> Cat := Animal clone
==>  Cat_0x3b5d8400:
  type             = "Cat"

Io> Cat speak
==> ...
Io> Cat speak = "meow"
==> meow
Io> Cat speak
==> meow
Io> Dog := Animal clone
==>  Dog_0x3b88edb0:
  type             = "Dog"

Io> Dog speak = "woof"
==> woof
Io> pets := list(Cat, Dog)
==> list( Cat_0x3b5d8400:
  speak            = "meow"
  type             = "Cat"
,  Dog_0x3b88edb0:
  speak            = "woof"
  type             = "Dog"
)
Io> pets foreach(speak)
==> woof
Io> 
==> nil
Io> pets
==> list( Cat_0x3b5d8400:
  speak            = "meow"
  type             = "Cat"
,  Dog_0x3b88edb0:
  speak            = "woof"
  type             = "Dog"
)


### Concurrency

[shakespeare.io](./shakespeare.io)

```sh
$ io ./shakespeare.io 
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
