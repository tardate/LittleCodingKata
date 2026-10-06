# #490 minutesUntilApocalypse

Using rust to survive the zombie apocalypse aka Cassidoo's Game of Death! Interview question of the week (2026-10-04).

## Notes

The [interview question of the week (2026-10-04)](https://buttondown.com/cassidoo/archive/u1f3a4-to-be-different-is-great-you-dont-want-to/):

> On Halloween night, a town is represented by a grid where 0 is an empty lot, 1 is a living person, and 2 is an infected zombie. Every minute, infection spreads to any living person directly above, below, left, or right of an infected zombie. Return the minimum number of minutes until no living people remain, or -1 if some people can never be reached.
>
> Example:
>
> ```ts
> > minutesUntilApocalypse([
>   [2, 1, 1],
>   [1, 1, 0],
>   [0, 1, 1]
> ])
> > 4
>
> > minutesUntilApocalypse([
>   [2, 1, 1],
>   [0, 1, 1],
>   [1, 0, 1]
> ])
> > -1
> ```

### Thinking about the Problem

We don't need to worry about diagonal infections, so we just need to match on the horizontal and vertical.

While processing, the main trap to avoid is to have changed states cascade within the same game turn e.g. if trying to mutate the game grid.
While perhaps not memory efficient, the simplest approach is probably to generate a new result array for each game turn, and repeat for as many turns as required before no state changes occur.

This is basically a version of [Conway's Game of Life](https://en.wikipedia.org/wiki/Conway%27s_Game_of_Life),
but for death!

### Initial Solution

Let's start a new challenge in rust.
I'm using [serde_json](https://docs.rs/serde_json/latest/serde_json/) to parse the input and pretty-print
the results, however this means that the order and styling of the output values are determined by the internal implementation.
I'm also adding
[exitfailure](https://crates.io/crates/exitfailure)
and [failure](https://docs.rs/failure/latest/failure/) crates for more friendly error messages to be returned.

```sh
carge new challenge
cd challenge
cargo add serde_json
cargo add exitfailure
cargo add failure
```

Here's a first run at an algorithm to maps the spread

```rust
pub fn minutes_until_apocalypse(grid: &Vec<Vec<i32>>) -> i32 {
    let mut current_grid = grid.clone();
    let mut iterations = 0;
    let rows = current_grid.len();
    let cols = current_grid[0].len();
    let directions = [(-1, 0), (1, 0), (0, -1), (0, 1)];

    loop {
        let mut next_grid = current_grid.clone();
        let mut mutations = false;

        for i in 0..rows {
            for j in 0..cols {
                if current_grid[i][j] == 2 {
                    // Spread to adjacent cells (up, down, left, right)
                    for (di, dj) in &directions {
                        let ni = (i as i32 + di) as usize;
                        let nj = (j as i32 + dj) as usize;
                        if ni < rows && nj < cols && current_grid[ni][nj] == 1 {
                            next_grid[ni][nj] = 2;
                            mutations = true;
                        }
                    }
                }
            }
        }

        if !mutations {
            // Check if any humans remain
            for row in &next_grid {
                if row.iter().any(|&cell| cell == 1) {
                    return -1;
                }
            }
            return iterations;
        }

        current_grid = next_grid;
        iterations += 1;
    }
}
```

Let's test it with the example data sets

```sh
$ cat ../data_eg1.json
[
  [2, 1, 1],
  [1, 1, 0],
  [0, 1, 1]
]
$ cargo run -- ../data_eg1.json
    Finished `dev` profile [unoptimized + debuginfo] target(s) in 0.01s
     Running `target/debug/challenge ../data_eg1.json`
# Given grid : [[2, 1, 1], [1, 1, 0], [0, 1, 1]]
# Result:
4
$ cat ../data_eg2.json
[
  [2, 1, 1],
  [0, 1, 1],
  [1, 0, 1]
]
$ cargo run -- ../data_eg2.json
    Finished `dev` profile [unoptimized + debuginfo] target(s) in 0.01s
     Running `target/debug/challenge ../data_eg2.json`
# Given grid : [[2, 1, 1], [0, 1, 1], [1, 0, 1]]
# Result:
-1
```

That's pretty good. There may be smarter ways of handling this by avoiding the array copies, but I can't see them right now.

### Tests

I've added some basic unit tests for the main algorithm functions:

```sh
$ cd challenge
$ cargo test
    Finished `test` profile [unoptimized + debuginfo] target(s) in 0.01s
     Running unittests src/lib.rs (target/debug/deps/challenge-931fdf72beda0a89)

running 2 tests
test tests::test_example1 ... ok
test tests::test_example2 ... ok

test result: ok. 2 passed; 0 failed; 0 ignored; 0 measured; 0 filtered out; finished in 0.00s

     Running unittests src/main.rs (target/debug/deps/challenge-710498536962879e)

running 0 tests

test result: ok. 0 passed; 0 failed; 0 ignored; 0 measured; 0 filtered out; finished in 0.00s

   Doc-tests challenge

running 0 tests

test result: ok. 0 passed; 0 failed; 0 ignored; 0 measured; 0 filtered out; finished in 0.00s

```

### Final Code

Final code comprises:

* [challenge/src/main.rs](./challenge/src/main.rs) - handles command-line invocation and option parsing
* [challenge/src/lib.rs](./challenge/src/lib.rs) - implements the actual algorithms

[main.rs](./challenge/src/main.rs):

```rust
use exitfailure::ExitFailure;
use failure::ResultExt;
use serde_json;

use challenge::minutes_until_apocalypse;

fn main() -> Result<(), ExitFailure> {
    let args: Vec<String> = std::env::args().collect();
    if args.len() != 2 {
        return Err(ExitFailure::from(
            failure::err_msg("Usage: challenge <grid.json>")
        ));
    }

    let grid_str = std::fs::read_to_string(&args[1])
        .context(format!("Failed to read grid file: {}", args[1]))?;
    let grid: Vec<Vec<i32>> = serde_json::from_str(&grid_str)
        .context("Failed to parse grid JSON")?;

    eprintln!("# Given grid : {:?}", grid);

    let result = minutes_until_apocalypse(&grid);
    eprintln!("# Result:");
    println!("{}", result);

    Ok(())
}
```

[challenge/src/lib.rs](./challenge/src/lib.rs):

```rust
//! algorithms for surviving the zombie apocalypse
//!

/// This function implements the logic for calculating minutes until the zombie apocalypse.
pub fn minutes_until_apocalypse(grid: &Vec<Vec<i32>>) -> i32 {
    let mut current_grid = grid.clone();
    let mut iterations = 0;
    let rows = current_grid.len();
    let cols = current_grid[0].len();
    let directions = [(-1, 0), (1, 0), (0, -1), (0, 1)];

    loop {
        let mut next_grid = current_grid.clone();
        let mut mutations = false;

        for i in 0..rows {
            for j in 0..cols {
                if current_grid[i][j] == 2 {
                    // Spread to adjacent cells (up, down, left, right)
                    for (di, dj) in &directions {
                        let ni = (i as i32 + di) as usize;
                        let nj = (j as i32 + dj) as usize;
                        if ni < rows && nj < cols && current_grid[ni][nj] == 1 {
                            next_grid[ni][nj] = 2;
                            mutations = true;
                        }
                    }
                }
            }
        }

        if !mutations {
            // Check if any humans remain
            for row in &next_grid {
                if row.iter().any(|&cell| cell == 1) {
                    return -1;
                }
            }
            return iterations;
        }

        current_grid = next_grid;
        iterations += 1;
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_example1() {
        assert_eq!(
            minutes_until_apocalypse(
              &vec![[2, 1, 1].to_vec(), [1, 1, 0].to_vec(), [0, 1, 1].to_vec()]
            ),
            4
        );
    }

    #[test]
    fn test_example2() {
        assert_eq!(
            minutes_until_apocalypse(
              &vec![[2, 1, 1].to_vec(), [0, 1, 1].to_vec(), [1, 0, 1].to_vec()]
            ),
            -1
        );
    }
}
```

## Credits and References

* [cassidoo's interview question of the week (2026-10-04)](https://buttondown.com/cassidoo/archive/u1f3a4-to-be-different-is-great-you-dont-want-to/)
* [serde_json](https://docs.rs/serde_json/latest/serde_json/)
* [failure](https://docs.rs/failure/latest/failure/)
* [exitfailure](https://crates.io/crates/exitfailure)
* [Conway's Game of Life](https://en.wikipedia.org/wiki/Conway%27s_Game_of_Life)
