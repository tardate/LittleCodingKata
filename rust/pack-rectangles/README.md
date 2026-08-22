# #475 packRectangles

Using rust to pack boxes; cassidoo's interview question of the week (2026-08-16).

## Notes

The [interview question of the week (2026-08-16)](https://buttondown.com/cassidoo/archive/u1f45b-the-most-certain-sign-of-wisdom-is/):

> Given the dimensions of a large rectangle n x m and a second rectangle a x b, return the maximum number of second rectangles that can be packed into the larger one without overlapping. You may rotate the smaller rectangle 90 degrees.
>
> Example:
>
> ```ts
> > packRectangles(10, 10, 3, 4)
> > 6
>
> > packRectangles(10, 6, 2, 3)
> > 10
>
> > packRectangles(10, 6, 11, 2)
> > 0
> ```

### Thinking about the Problem

Packing boxes efficiently is such a common problem in logistics and graphics that I was sure there would be well-known algorithms.
Aside from some vague memories of dynamic programming and integer programming exercises, I didn't have specifics in mind, so I did some research.

Luckily we have a tightly constrained problem: only 2D, and only 90˚ rotations allowed.

If the problem eventually evolves into "pack arbitrary rectangles into a rectangle", then we've entering the much harder 2D bin packing / rectangle packing family.

Common approaches include:

| Algorithm                           | Typical use                         |
| ----------------------------------- | ----------------------------------- |
| Simple grid formula                 | Identical rectangles, axis-aligned  |
| Dynamic programming                 | Identical rectangles with rotation  |
| Guillotine / recursive partitioning | Practical packing                   |
| Skyline algorithm                   | Packing many rectangles efficiently |
| Maximal rectangles                  | 2D texture/bin packing              |
| Backtracking                        | Small exact problems                |
| Branch-and-bound                    | Exact optimization                  |
| Integer programming                 | Exact/general formulations          |
| Genetic algorithms                  | Large approximate problems          |

### A First Go

Created a new app `cargo new packer`, structured it as follows:

* [main.rs](./packer/src/main.rs)
    * main controller
    * accepts box dimensions, calls the implementation, prints the result
* [lib.rs](./packer/src/lib.rs)
    * implements the packing function
    * I decided to go with conventional rust linting practices rather than follow the specification to the letter, hence snake-case `pack_rectangles()` instead of `packRectangles()`.

My first approach goes strip by strip and determines
the maximum number of boxes that could be packed.
It assumes that each row is packed at the same orientation, but rows don't have to have the same orientation:

```rust
pub fn pack_rectangles(n: usize, m: usize, a: usize, b: usize) -> usize {
    if n == 0 || m == 0 || a == 0 || b == 0 {
        return 0;
    }

    // packed[h] = maximum number of rectangles packed in exactly h units of height.
    let mut packed = vec![None; m + 1];
    packed[0] = Some(0);

    for h in 0..=m {
        let Some(current) = packed[h] else {
            continue;
        };

        // Small rectangle is a high x b wide.
        if a <= m && b <= n && h + a <= m {
            let count = n / b;
            let value = current + count;

            packed[h + a] = Some(
                packed[h + a]
                    .map_or(value, |old| old.max(value))
            );
        }

        // Rotated: b high x a wide.
        if b <= m && a <= n && h + b <= m {
            let count = n / a;
            let value = current + count;

            packed[h + b] = Some(
                packed[h + b]
                    .map_or(value, |old| old.max(value))
            );
        }
    }

    packed.into_iter()
        .flatten()
        .max()
        .unwrap_or(0)
}
```

Running this, I find it basically works... but I am getting a better result for one of the examples??

```sh
$ cd packer
$ cargo run
Usage: target/debug/packer <n> <m> <a> <b>
$ cargo run -- 10 10 3 4
7
$ cargo run -- 10 6 2 3
10
$ cargo run -- 10 6 11 2
0
```

With n=10 m=10 a=3 b=4, we are getting 7 boxes packed instead of the expected 6. The planned packing scheme is as follows:

```ascii
+-------------+
| 3x4 3x4     |
| 3x4 3x4     |
| 4x3 4x3 4x3 |
+-------------+
```

### Refined Solution

So this makes me re-examine the requirements.
Specifically:

> You may rotate the smaller rectangle 90 degrees.

It seems this means the smaller boxes can be rotated, but all boxes must have the same rotation.

This is actually a simpler problem to solve!

If the smaller rectangles have the same dimensions and orientation and must be aligned with the large rectangle, the obvious solutions are:

* For orientation a × b: `(n/a) * (m/b)`
* For orientation b × a: `(n/b) * (m/a)`
* And we pick the maximum

My original implementation gets renamed `pack_rectangles_v1` and I try again. This is much simpler:

```rust
pub fn pack_rectangles(n: usize, m: usize, a: usize, b: usize) -> usize {
    if n == 0 || m == 0 || a == 0 || b == 0 {
        return 0;
    }
    let orientation1 = (n / a) * (m / b);
    let orientation2 = (n / b) * (m / a);
    orientation1.max(orientation2)
}
```

And it works as expected:

```sh
$ cd packer
$ cargo run -- 10 10 3 4
6
$ cargo run -- 10 6 2 3
10
$ cargo run -- 10 6 11 2
0
```

### Tests

I've added some basic unit tests for the main algorithm:

```sh
$ cd packer
$ cargo test
    Finished `test` profile [unoptimized + debuginfo] target(s) in 0.00s
     Running unittests src/lib.rs (target/debug/deps/packer-e999e32c5b987679)

running 6 tests
test tests::test_pack_rectangles_example1 ... ok
test tests::test_pack_rectangles_example2 ... ok
test tests::test_pack_rectangles_example3 ... ok
test tests::test_pack_rectangles_v1_example1 ... ok
test tests::test_pack_rectangles_v1_example2 ... ok
test tests::test_pack_rectangles_v1_example3 ... ok

test result: ok. 6 passed; 0 failed; 0 ignored; 0 measured; 0 filtered out; finished in 0.00s

     Running unittests src/main.rs (target/debug/deps/packer-b6cb8d391a5428a3)

running 0 tests

test result: ok. 0 passed; 0 failed; 0 ignored; 0 measured; 0 filtered out; finished in 0.00s

   Doc-tests packer

running 0 tests

test result: ok. 0 passed; 0 failed; 0 ignored; 0 measured; 0 filtered out; finished in 0.00s
```

### Final Code

[packer/src/main.rs](./packer/src/main.rs):

```rust
use std::env;
use packer;

fn arg_as_usize(arg: &str) -> usize {
    arg.parse().unwrap_or_else(|_| {
        eprintln!("Error: '{}' is not a valid integer", arg);
        std::process::exit(1);
    })
}

fn main() {
    let args: Vec<String> = env::args().collect();
    if args.len() != 5 {
        eprintln!("Usage: {} <n> <m> <a> <b>", args[0]);
        std::process::exit(1);
    }
    let n: usize = arg_as_usize(&args[1]);
    let m: usize = arg_as_usize(&args[2]);
    let a: usize = arg_as_usize(&args[3]);
    let b: usize = arg_as_usize(&args[4]);

    let result = packer::pack_rectangles(n, m, a, b);
    println!("{}", result);
}
```

[packer/src/lib.rs](./packer/src/lib.rs):

```rust
pub fn pack_rectangles(n: usize, m: usize, a: usize, b: usize) -> usize {
    if n == 0 || m == 0 || a == 0 || b == 0 {
        return 0;
    }
    let orientation1 = (n / a) * (m / b);
    let orientation2 = (n / b) * (m / a);
    orientation1.max(orientation2)
}

pub fn pack_rectangles_v1(n: usize, m: usize, a: usize, b: usize) -> usize {
    if n == 0 || m == 0 || a == 0 || b == 0 {
        return 0;
    }

    // packed[h] = maximum number of rectangles packed in exactly h units of height.
    let mut packed = vec![None; m + 1];
    packed[0] = Some(0);

    for h in 0..=m {
        let Some(current) = packed[h] else {
            continue;
        };

        // Small rectangle is a high x b wide.
        if a <= m && b <= n && h + a <= m {
            let count = n / b;
            let value = current + count;

            packed[h + a] = Some(
                packed[h + a]
                    .map_or(value, |old| old.max(value))
            );
        }

        // Rotated: b high x a wide.
        if b <= m && a <= n && h + b <= m {
            let count = n / a;
            let value = current + count;

            packed[h + b] = Some(
                packed[h + b]
                    .map_or(value, |old| old.max(value))
            );
        }
    }

    packed.into_iter()
        .flatten()
        .max()
        .unwrap_or(0)
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_pack_rectangles_example1() {
        assert_eq!(pack_rectangles(10, 10, 3, 4), 6);
    }

    #[test]
    fn test_pack_rectangles_example2() {
        assert_eq!(pack_rectangles(10, 6, 2, 3), 10);
    }

    #[test]
    fn test_pack_rectangles_example3() {
        assert_eq!(pack_rectangles(10, 6, 11, 2), 0);
    }


    #[test]
    fn test_pack_rectangles_v1_example1() {
        assert_eq!(pack_rectangles_v1(10, 10, 3, 4), 7);
    }

    #[test]
    fn test_pack_rectangles_v1_example2() {
        assert_eq!(pack_rectangles_v1(10, 6, 2, 3), 10);
    }

    #[test]
    fn test_pack_rectangles_v1_example3() {
        assert_eq!(pack_rectangles_v1(10, 6, 11, 2), 0);
    }
}
```

## Credits and References

* [cassidoo's interview question of the week (2026-08-16)](https://buttondown.com/cassidoo/archive/u1f45b-the-most-certain-sign-of-wisdom-is/)
