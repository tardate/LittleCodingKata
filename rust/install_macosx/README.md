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

My first installation was with rust 1.7.0 on an Intel-based MacBook.

```sh
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

```sh
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
```

After installation:

```sh
$ brew info rust
==> rust: stable 1.86.0 (bottled), HEAD
Safe, concurrent, practical language
https://www.rust-lang.org/
Installed
/opt/homebrew/Cellar/rust/1.86.0 (3,648 files, 322.5MB) *
  Poured from bottle using the formulae.brew.sh API on 2025-04-16 at 11:53:42
From: https://github.com/Homebrew/homebrew-core/blob/HEAD/Formula/r/rust.rb
License: Apache-2.0 OR MIT
==> Dependencies
Required: libgit2 ✔, libssh2 ✔, llvm@19 ✔, openssl@3 ✔, pkgconf ✔, zstd ✔
==> Requirements
Required: macOS >= 10.12 (or Linux) ✔
==> Options
--HEAD
 Install HEAD version
==> Caveats
Link this toolchain with `rustup` under the name `system` with:
  rustup toolchain link system "$(brew --prefix rust)"

If you use rustup, avoid PATH conflicts by following instructions in:
  brew info rustup

Bash completion has been installed to:
  /opt/homebrew/etc/bash_completion.d
==> Analytics
install: 53,365 (30 days), 136,758 (90 days), 495,659 (365 days)
install-on-request: 44,207 (30 days), 109,219 (90 days), 377,053 (365 days)
build-error: 149 (30 days)
$ rustc --version
rustc 1.40.0
$ cargo --version
cargo 1.40.0
```

### Rust on Apple Silicon

It's time to get rust running on my new(er) iMac running macOS 15.4 on Apple M3 silicon.

```sh
$ brew install rust
==> Installing rust
==> Pouring rust--1.86.0.arm64_sequoia.bottle.tar.gz
==> Caveats
Link this toolchain with `rustup` under the name `system` with:
  rustup toolchain link system "$(brew --prefix rust)"

If you use rustup, avoid PATH conflicts by following instructions in:
  brew info rustup

Bash completion has been installed to:
  /opt/homebrew/etc/bash_completion.d
==> Summary
🍺  /opt/homebrew/Cellar/rust/1.86.0: 3,648 files, 322.5MB
==> Running `brew cleanup rust`...
Disable this behaviour by setting HOMEBREW_NO_INSTALL_CLEANUP.
Hide these hints with HOMEBREW_NO_ENV_HINTS (see `man brew`).
==> Caveats
==> rust
Link this toolchain with `rustup` under the name `system` with:
  rustup toolchain link system "$(brew --prefix rust)"

If you use rustup, avoid PATH conflicts by following instructions in:
  brew info rustup

Bash completion has been installed to:
  /opt/homebrew/etc/bash_completion.d
$ rustc --version
rustc 1.86.0 (05f9846f8 2025-03-31) (Homebrew)
$ cargo --version
cargo 1.86.0
```

## Credits and References

* [Rust Downloads](https://www.rust-lang.org/downloads.html)
* [brewformulas - Rust](http://brewformulas.org/Rust)
