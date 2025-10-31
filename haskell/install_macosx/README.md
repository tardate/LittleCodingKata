# #211 Haskell/install_macosx

Getting a Haskell compiler running under macOS

## Notes

There are at least three methods:

* binary installation - see [Downloads for OS X](https://www.haskell.org/downloads/osx)
* brew - see [Quick setup for GHC 7.11 and later](https://ghc.haskell.org/trac/ghc/wiki/Building/Preparation/macOSX)
* source compilation - see [Building and Porting GHC](https://ghc.haskell.org/trac/ghc/wiki/Building)

### brew

I use [homebrew](https://github.com/Homebrew/homebrew) to manage most of my software installation, so I'll use that.

The brew formula for installing Haskell is [ghc](https://github.com/Homebrew/homebrew/blob/master/Library/Formula/ghc.rb).
Note there was an earlier formula called `haskell-platform`.

```sh
$ brew install ghc
==> Downloading https://homebrew.bintray.com/bottles/ghc-7.10.3b.yosemite.bottle.tar.gz
######################################################################## 100.0%
==> Pouring ghc-7.10.3b.yosemite.bottle.tar.gz
🍺  /usr/local/Cellar/ghc/7.10.3b: 5,436 files, 826.8M

$ ghc --version
The Glorious Glasgow Haskell Compilation System, version 7.10.3
```

So far, so good..

### Updating for macOS Sequoia on Apple Silicon

It's been a while since I've fired up Haskell. Installing again on macOS 15.7.1, and we now have Haskell 9.12.2:

```sh
$ ghc --version
The Glorious Glasgow Haskell Compilation System, version 9.12.2
```

## Credits and References

* [Quick setup for GHC 7.11 and later](https://ghc.haskell.org/trac/ghc/wiki/Building/Preparation/macOSX)
* [Downloads for OS X](https://www.haskell.org/downloads/osx)
* [Building and Porting GHC](https://ghc.haskell.org/trac/ghc/wiki/Building)
* [ghc brew formula](https://github.com/Homebrew/homebrew/blob/master/Library/Formula/ghc.rb)
