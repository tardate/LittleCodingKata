# Installing Rust for MacOSX

Getting rust running under MacOSX

## Notes

There are at least three methods:
* binary installation - see [Rust Downloads](https://www.rust-lang.org/downloads.html)
* shell installation - see [Rust Downloads](https://www.rust-lang.org/downloads.html)
* Homebrew
* source compilation - see [GitHub repo](https://github.com/rust-lang/rust)

### brew

I use [homebrew](https://github.com/Homebrew/homebrew) to manage most of my software installation, so I'll use that.

```
$ brew install rust
==> Installing dependencies for rust: libssh2
==> Installing rust dependency: libssh2
==> Downloading https://homebrew.bintray.com/bottles/libssh2-1.7.0.yosemite.bottle.tar.gz
######################################################################## 100.0%
==> Pouring libssh2-1.7.0.yosemite.bottle.tar.gz
🍺  /usr/local/Cellar/libssh2/1.7.0: 180 files, 798.4K
==> Installing rust
==> Downloading https://homebrew.bintray.com/bottles/rust-1.7.0.yosemite.bottle.tar.gz
######################################################################## 100.0%
==> Pouring rust-1.7.0.yosemite.bottle.tar.gz
==> Caveats
Bash completion has been installed to:
  /usr/local/etc/bash_completion.d

zsh completion has been installed to:
  /usr/local/share/zsh/site-functions
==> Summary
🍺  /usr/local/Cellar/rust/1.7.0: 10,323 files, 227.8M
$ rustc --version
rustc 1.7.0
```

So far, so good..

## Credits and References
* [Rust Downloads](https://www.rust-lang.org/downloads.html)
* [brewformulas - Rust](http://brewformulas.org/Rust)
