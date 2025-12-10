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

## A Quick Test Drive

The last release for macOS was for Intel, so there are no binaries compatible with modern Apple Silicon machines.
I'll do my test drive with Ubuntu on Intel..

### Objects

### Concurrency

[coroutine](./coroutine.io)

## Credits and References

* <https://iolanguage.org/>
* <https://github.com/IoLanguage/io>
* <https://en.wikipedia.org/wiki/Io_(programming_language)>
