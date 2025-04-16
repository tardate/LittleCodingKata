# #xxx catsay

Building the catsay example from Practical Rust Projects, learning about making command-line programs with Rust.

## Notes

The catsay example from [Practical Rust Projects](../practical-rust-projects/)
is used to demonstrate techniques for making command-line programs with Rust.

* accepting command-line arguments

## Building catsay

```sh
cargo new --bin catsay
    Creating binary (application) `catsay` package
note: see more `Cargo.toml` keys and their definitions at https://doc.rust-lang.org/cargo/reference/manifest.html
$ cd catsay
$ cargo run
   Compiling catsay v0.1.0 (/Users/paulgallagher/MyGithub/tardate/LittleCodingKata/rust/catsay/catsay)
    Finished `dev` profile [unoptimized + debuginfo] target(s) in 0.28s
     Running `target/debug/catsay`
Hello, world!

```

### Step 1: reading command-line arguments

Doing the bare minimum to accept a message argument
with [args](https://doc.rust-lang.org/std/env/fn.args.html)
and print the cat saying it:

```rust
fn main() {
    let message = std::env::args().nth(1).expect("Please provide a message");
    println!("{}", message);
    println!(" \\");
    println!("  \\");
    println!("    /\\_/\\");
    println!("   ( o o )");
    println!("   =( I )=");
}
```

```sh
$ cargo run "Hi!"
    Finished `dev` profile [unoptimized + debuginfo] target(s) in 0.00s
     Running `target/debug/catsay 'Hi'\!''`
Hi!
 \
  \
    /\_/\
   ( o o )
   =( I )=
```

## Credits and References

* [Practical Rust Projects](../practical-rust-projects/)
