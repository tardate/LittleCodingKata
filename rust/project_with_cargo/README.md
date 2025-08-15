# #103 Using Cargo

Using Cargo to create and manage a rust project.

## Notes

Cargo is the Rust package manager:

* generates project skeletons
* downloads package dependencies
* compiles your packages
* makes distributable packages
* uploads distributions to [crates.io](https://crates.io/), the Rust community’s package registry

i.e. similar to bundler and rubygems in the Ruby world.

### Making a Project with Cargo

```sh
$ cargo new helloc
     Created binary (application) `helloc` package
$ cd helloc/
```

Generated files:

* `helloc/Cargo.toml` - package manifest
* `helloc/src/main.rs` - main source file (hello world placeholder)

Building and Run:

```sh
$ cargo build
   Compiling helloc v0.1.0 (.../project_with_cargo/helloc)
    Finished dev [unoptimized + debuginfo] target(s) in 1.61s
$ target/debug/helloc
Hello, world!
```

Alternatively, use `cargo run` to update compilation and run (like using a makefile)

```sh
$ cargo run
    Finished dev [unoptimized + debuginfo] target(s) in 0.08s
     Running `target/debug/helloc`
Hello, world!
```

Build for release

```sh
$ cargo build --release
   Compiling helloc v0.1.0 (.../project_with_cargo/helloc)
    Finished release [optimized] target(s) in 1.48s
```

## Adding Dependencies

I've picked the [rand](https://crates.io/crates/rand) crate for a simple example.
Adding to the manifest:

```txt
[dependencies]
rand = "0.7"
```

Running `cargo` installs the dependency and builds the updated project (which exercises some basic random capabilities):

```sh
$ cargo run
    Finished dev [unoptimized + debuginfo] target(s) in 0.02s
     Running `target/debug/helloc`
Using the rand crate
--------------------
Random unsigned 8-bit number: 47
Random boolean: true
Random choice of direction: ⬋
Unshuffled numbers: [1, 2, 3, 4, 5]
Shuffled: [2, 4, 5, 1, 3]
```

## Credits and References

* [The Cargo Book](https://doc.rust-lang.org/cargo/)
* [The Rust community crate registry](https://crates.io/)
* [TOML (Tom's Obvious, Minimal Language)](https://github.com/toml-lang/toml) - Cargo configuration format
* [crate: rand](https://crates.io/crates/rand)
* [The Rust Rand Book](https://rust-random.github.io/book/)
