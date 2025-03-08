# #289 Installing Rust for macOS

Getting rust running under macOS

## Notes

There are at least four methods:

* binary installation - see [Rust Downloads](https://www.rust-lang.org/downloads.html)
* shell installation - see [Rust Downloads](https://www.rust-lang.org/downloads.html)
* Homebrew
* source compilation - see [GitHub repo](https://github.com/rust-lang/rust)
* [rustup](https://rustup.rs/) installer

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

## Later

Several updates later...

```
$ brew info rust
rust: stable 1.40.0 (bottled), HEAD
Safe, concurrent, practical language
https://www.rust-lang.org/
/usr/local/Cellar/rust/1.40.0 (27,438 files, 639.3MB) *
  Poured from bottle on 2020-01-09 at 10:47:18
From: https://github.com/Homebrew/homebrew-core/blob/master/Formula/rust.rb
==> Dependencies
Build: cmake ✔
Required: libssh2 ✔, openssl@1.1 ✔, pkg-config ✔
==> Options
--HEAD
  Install HEAD version
==> Analytics
install: 7,931 (30 days), 30,613 (90 days), 123,112 (365 days)
install-on-request: 5,757 (30 days), 21,727 (90 days), 88,186 (365 days)
build-error: 0 (30 days)
$ rustc --version
rustc 1.40.0
$ cargo --version
cargo 1.40.0
```

## Credits and References

* [Rust Downloads](https://www.rust-lang.org/downloads.html)
* [brewformulas - Rust](http://brewformulas.org/Rust)
