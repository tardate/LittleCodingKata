# #xxx hyperfactorial

Using rust to calculate the hyper-factorial of a non-negative integer; cassidoo's interview question of the week (2025-09-29).

## Notes

The [interview question of the week (2025-09-29)](https://buttondown.com/cassidoo/archive/i-recommend-the-freedom-that-comes-from-asking/)
has us delve into more number theory and face up to the limits of integer primitives.

> Given the non-negative integer n , output the value of its hyperfactorial. Don't worry about outputs exceeding your language's integer limit.
>
> Examples:
>
> ```ts
> > hyperfactorial(0)
> > 1
>
> > hyperfactorial(2)
> > 4
> >
> > hyperfactorial(3)
> > 108
>
> > hyperfactorial(7)
> > 3319766398771200000
> ```

### What is a "Hyperfactorial"?

The hyperfactorial of a non-negative integer `n` is the product of the numbers from 1 to `n`, where each number is raised to the power of itself.

It is denoted as `H(n)`.

```math
H(n)=1^1 × 2^2 × 3^3 × .. n^n
```

### Initial Implementation

I've created a rust project called "hyperfactorial":

```sh
cargo new hyperfactorial
```

The basic implementation is quite straight-forward. The main issue is dealing with number sizes.
I'll just stick with standard library limits rather than reach for one a the many "bigint" libraries.

Since the [`u128#pow`](https://doc.rust-lang.org/stable/std/primitive.u128.html#method.pow) function only takes a `u32` exponent,
this is an initial limitation: `n` can't be larger.
I'll also use the largest primitive possible for the result - [u128](https://doc.rust-lang.org/stable/std/primitive.u128.html).

```rust
pub fn hyperfactorial(n: u32) -> u128 {
    let mut product: u128 = 1;
    for i in 1..=n {
        let base = i as u128;
        let exponent = i as u32;
        let term = base.pow(exponent);
        product *= term;
    }
    product
}
```

Let's check against the examples provided. All good! And performance is fine too.

```sh
$ cargo run -- 1
    Finished `dev` profile [unoptimized + debuginfo] target(s) in 0.00s
     Running `target/debug/hyperfactorial 1`
1
$ cargo run -- 2
    Finished `dev` profile [unoptimized + debuginfo] target(s) in 0.00s
     Running `target/debug/hyperfactorial 2`
4
$ cargo run -- 3
    Finished `dev` profile [unoptimized + debuginfo] target(s) in 0.00s
     Running `target/debug/hyperfactorial 3`
108
$ time cargo run -- 7
    Finished `dev` profile [unoptimized + debuginfo] target(s) in 0.00s
     Running `target/debug/hyperfactorial 7`
3319766398771200000

real    0m0.211s
user    0m0.046s
sys     0m0.020s
```

Given that we're using u128 for the result, turns out the largest hyperfactorial we can calculate is 9!
Anything larger overflows:

```sh
$ target/debug/hyperfactorial 9
21577941222941856209168026828800000
$ target/debug/hyperfactorial 10

thread 'main' panicked at src/lib.rs:7:9:
attempt to multiply with overflow
note: run with `RUST_BACKTRACE=1` environment variable to display a backtrace
```

### Tests

I've added some basic unit tests for the main algorithm:

```sh
$ cargo test
    Finished `test` profile [unoptimized + debuginfo] target(s) in 0.00s
     Running unittests src/lib.rs (target/debug/deps/hyperfactorial-b78f34524cd5858c)

running 3 tests
test tests::test_hyperfactorial_examples ... ok
test tests::test_largest_hyperfactorial ... ok
test tests::test_hyperfactorial_overflow - should panic ... ok

test result: ok. 3 passed; 0 failed; 0 ignored; 0 measured; 0 filtered out; finished in 0.00s

     Running unittests src/main.rs (target/debug/deps/hyperfactorial-01ba3700b796986a)

running 0 tests

test result: ok. 0 passed; 0 failed; 0 ignored; 0 measured; 0 filtered out; finished in 0.00s

   Doc-tests hyperfactorial

running 0 tests

test result: ok. 0 passed; 0 failed; 0 ignored; 0 measured; 0 filtered out; finished in 0.00s
```

### Example Code

[hyperfactorial/src/main.rs](./numberwang/src/main.rs):

```rust
use std::env;
use hyperfactorial;


fn main() {
    let args: Vec<String> = env::args().collect();
    if args.len() < 2 {
        eprintln!("Usage: {} <number>", args[0]);
        std::process::exit(1);
    }
    let number: u32 = args[1].parse().unwrap_or_else(|_| {
        eprintln!("Error: '{}' is not a valid integer", args[1]);
        std::process::exit(1);
    });

    let result = hyperfactorial::hyperfactorial(number);
    println!("{}", result);
}
```

[hyperfactorial/src/lib.rs](./numberwang/src/lib.rs):

```rust
pub fn hyperfactorial(n: u32) -> u128 {
    let mut product: u128 = 1;
    for i in 1..=n {
        let base = i as u128;
        let exponent = i as u32;
        let term = base.pow(exponent);
        product *= term;
    }
    product
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_hyperfactorial_examples() {
        assert_eq!(hyperfactorial(1), 1);
        assert_eq!(hyperfactorial(2), 4);
        assert_eq!(hyperfactorial(3), 108);
        assert_eq!(hyperfactorial(7), 3_319_766_398_771_200_000u128);
    }

    #[test]
    fn test_largest_hyperfactorial() {
        assert_eq!(hyperfactorial(9), 21_577_941_222_941_856_209_168_026_828_800_000u128);
    }

    #[test]
    #[should_panic]
    fn test_hyperfactorial_overflow() {
        hyperfactorial(10);
    }
}
```

## Credits and References

* [cassidoo's interview question of the week (2025-09-29)](https://buttondown.com/cassidoo/archive/i-recommend-the-freedom-that-comes-from-asking/)
* <https://doc.rust-lang.org/stable/std/primitive.u128.html#method.pow>
* <https://doc.rust-lang.org/stable/std/primitive.u128.html>
