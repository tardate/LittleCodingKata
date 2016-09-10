# Installing Go for MacOSX

Getting a Go compiler running under MacOSX

## Notes

There are at least three methods:
* binary installation - see [Mac OS X package installer](https://golang.org/doc/install#install)
* brew - see [the Go formula](http://brewformulas.org/Go)
* source compilation - see [Installing Go from source](https://golang.org/doc/install/source)

### brew

I use [homebrew](https://github.com/Homebrew/homebrew) to manage most of my software installation, so I'll use that.

The brew formula for installation is [go](http://brewformulas.org/Go).

```
$ brew install go
==> Downloading https://homebrew.bintray.com/bottles/go-1.6.2.yosemite.bottle.tar.gz
######################################################################## 100.0%
==> Pouring go-1.6.2.yosemite.bottle.tar.gz
==> Caveats
As of go 1.2, a valid GOPATH is required to use the `go get` command:
  https://golang.org/doc/code.html#GOPATH

You may wish to add the GOROOT-based install location to your PATH:
  export PATH=$PATH:/usr/local/opt/go/libexec/bin
==> Summary
🍺  /usr/local/Cellar/go/1.6.2: 5,778 files, 325.3M

$ go version
go version go1.6.2 darwin/amd64
```

So far, so good..

## Credits and References
* [Getting Started](https://golang.org/doc/install) - Go doc
* [Go Downloads](https://golang.org/dl/)
* [Get Setup](http://www.golangbootcamp.com/book/get_setup) - GO BOOTCAMP
