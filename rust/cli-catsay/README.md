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

### Step 2: Handling Complex Arguments with StructOpt

The
[structopt](https://docs.rs/structopt/latest/structopt/)
library provides a simple system for handling complex argument.

Note: structopt is now in maintenance mode

Add `structopt = "0.3.5"` to [Cargo.toml](./catsay/Cargo.toml), and update the code:

```rust
extern crate structopt;

use structopt::StructOpt;

#[derive(StructOpt)]
struct Options {
    message: String,
}

fn main() {
    let options = Options::from_args();
    let message = options.message;
    println!("{}", message);
    // ... print the cat...
}

```

Handling arg errors:

```sh
$ cargo run
    Finished `dev` profile [unoptimized + debuginfo] target(s) in 0.01s
     Running `target/debug/catsay`
error: The following required arguments were not provided:
    <message>

USAGE:
    catsay <message>

For more information try --help
```

Getting help:

```sh
$ cargo run -- --help
    Finished `dev` profile [unoptimized + debuginfo] target(s) in 0.01s
     Running `target/debug/catsay --help`
catsay 0.1.0

USAGE:
    catsay <message>

FLAGS:
    -h, --help       Prints help information
    -V, --version    Prints version information

ARGS:
    <message>
```

Running successfully:

```sh
$ cargo run "Hi!"
   Compiling catsay v0.1.0 (/Users/paulgallagher/MyGithub/tardate/LittleCodingKata/rust/cli-catsay/catsay)
    Finished `dev` profile [unoptimized + debuginfo] target(s) in 0.12s
     Running `target/debug/catsay 'Hi'\!''`
Hi!
 \
  \
    /\_/\
   ( o o )
   =( I )=
```

### Step 3: Binary Flags

Adding a "dead cat" flag.

Add and use the new option:

```rust
    #[structopt(short = "d", long = "dead", help = "Make the cat appear dead")]
    dead: bool,
    ...
    let eye = if options.dead { "x" } else { "o" };
    ...
    println!("   ( {eye} {eye} )", eye=eye);
```

```sh
$ cargo run "Ouch!" -d
    Finished `dev` profile [unoptimized + debuginfo] target(s) in 0.01s
     Running `target/debug/catsay 'Ouch'\!'' -d`
Ouch!
 \
  \
    /\_/\
   ( x x )
   =( I )=
```

### Step 4: Printing Errors to STDERR

Use `eprintln!` to send messages to STDERR:

```rust
if message.to_lowercase() == "woof" {
    eprintln!("A cat shouldn't bark like a dog!");
}
```

```sh
$ cargo run "Woof" > stdout.txt 2> stderr.txt
$ cat stdout.txt
Woof
 \
  \
    /\_/\
   ( o o )
   =( I )=
$ cat stderr.txt
   Compiling catsay v0.1.0 (/Users/paulgallagher/MyGithub/tardate/LittleCodingKata/rust/cli-catsay/catsay)
    Finished `dev` profile [unoptimized + debuginfo] target(s) in 0.11s
     Running `target/debug/catsay Woof`
A cat shouldn't bark like a dog!
```

## Credits and References

* [Practical Rust Projects](../practical-rust-projects/)
