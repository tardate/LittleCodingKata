# #346 Group Audio Files

Using rust to organise songs into playlists; cassidoo's interview question of the week (2025-08-11).

## Notes

The [interview question of the week (2025-08-11)](https://buttondown.com/cassidoo/archive/new-sentences-have-appeared-on-earth-not-written/)
is an interesting example of distributing and bucketing data:

> Given an array of audio file durations, write a function to group the files into playlists such that each playlist's total duration does not exceed a given limit maxDuration. Return an array of playlists, where each playlist is an array of file durations. Try to minimize the number of playlists.
>
> Example:
>
> ```js
> const files = [120, 90, 60, 150, 80];
> const maxDuration = 200;
>
> groupAudioFiles(files, maxDuration)
> => [[150], [120,80], [90,60]]
>
> groupAudioFiles(files, 160)
> => [[150], [120], [90,60], [80]]
> ```

I decided to tackle the question with rust this time.

## Algorithms

Distributing items of various sizes into the fewest number of buckets, while aiming for an even distribution within those buckets, is a classic optimization problem often related to the bin packing problem or multi-way number partitioning.
The problem has been proven NP-hard, but many approximation algorithms exist.

Some algorithmic approaches:

* Greedy Algorithms
    * [First Fit Decreasing (FFD)](https://en.wikipedia.org/wiki/First-fit-decreasing_bin_packing): Sort items in descending order of size. For each item, place it into the first bucket that can accommodate it. This is a simple and often effective heuristic.
    * [Best Fit Decreasing (BFD)](https://en.wikipedia.org/wiki/Best-fit_bin_packing): Similar to FFD, but for each item, place it into the bucket that can accommodate it with the least remaining space. This tends to create more uniformly filled buckets.
* Scheduling algorithms
    * algorithms like [Longest Processing Time (LPT)](https://en.wikipedia.org/wiki/Longest-processing-time-first_scheduling) scheduling can be adapted. In LPT, tasks (items) are ordered by decreasing processing time (size), and then assigned to the machine (bucket) that currently has the least total workload. This is essentially First Fit Decreasing (FFD) but using different terminology!

### First Pass - FFD

I've created a rust project called "gaffer":

```sh
cargo new gaffer
```

First off, just implementing the First Fit Decreasing (FFD) algorithm.
This is a naïve rendering of the basic algorithm:

```rust
pub fn ffd(durations: Vec<i32>, max_duration: i32) -> Vec<Vec<i32>> {
  let mut result: Vec<Vec<i32>> = Vec::new();
  let mut sorted_durations = durations.clone();
  sorted_durations.sort_by(|a, b| b.cmp(a));
  for duration in sorted_durations {
      let mut added = false;
      for group in &mut result {
          let total: i32 = group.iter().sum();
          if total + duration <= max_duration {
              group.push(duration);
              added = true;
              break;
          }
      }
      if !added {
          result.push(vec![duration]);
      }
  }
  result
}
```

Running with the given examples, getting the expected results:

```sh
$ echo "120, 90, 60, 150, 80" | cargo run -- -m 200
  Compiling gaffer v0.1.0 (~/LittleCodingKata/rust/group-audio-files/gaffer)
    Finished `dev` profile [unoptimized + debuginfo] target(s) in 0.11s
    Running `target/debug/gaffer -m 200`
Max duration is set to 200
Enter the comma-separated list of song durations:
Song durations: [120, 90, 60, 150, 80]
Playlists (by FDD): [[150], [120, 80], [90, 60]]
$ echo "120, 90, 60, 150, 80" | target/debug/gaffer -m 160
Max duration is set to 160
Enter the comma-separated list of song durations:
Song durations: [120, 90, 60, 150, 80]
Playlists (by FDD): [[150], [120], [90, 60], [80]]
```

If song durations exceed playlist duration, they will still be scheduled:

```sh
$ echo "120, 90, 60, 150, 80" | target/debug/gaffer -m 140
Max duration is set to 140
Enter the comma-separated list of song durations:
Song durations: [120, 90, 60, 150, 80]
Playlists (by FDD): [[150], [120], [90], [80, 60]]
```

### Tests

I've added some basic unit tests for the main algorithm functions:

```sh
$ cargo test
   Compiling gaffer v0.1.0 (~/LittleCodingKata/rust/group-audio-files/gaffer)
    Finished `test` profile [unoptimized + debuginfo] target(s) in 0.13s
     Running unittests src/lib.rs (target/debug/deps/gaffer-39e94afbf3e080de)

running 3 tests
test tests::ffd_handles_songs_longer_than_playlist ... ok
test tests::ffd_works_with_example1 ... ok
test tests::ffd_works_with_example2 ... ok

test result: ok. 3 passed; 0 failed; 0 ignored; 0 measured; 0 filtered out; finished in 0.00s

     Running unittests src/main.rs (target/debug/deps/gaffer-aec5488147b482a8)

running 0 tests

test result: ok. 0 passed; 0 failed; 0 ignored; 0 measured; 0 filtered out; finished in 0.00s

   Doc-tests gaffer

running 0 tests

test result: ok. 0 passed; 0 failed; 0 ignored; 0 measured; 0 filtered out; finished in 0.00s
```

### Example Code

Final code comprises:

* [gaffer/src/main.rs](./gaffer/src/main.rs) - handles command-line invocation and option parsing
* [gaffer/src/lib.rs](./gaffer/src/lib.rs) - implements the bucketing algorithm(s)

main.rs:

```rust
use std::io;
use std::env;
use gaffer;

use failure::ResultExt;
use exitfailure::ExitFailure;

fn main() -> Result<(), ExitFailure> {
    let args: Vec<String> = env::args().collect();
    let max_duration: i32 = args.iter()
        .position(|arg| arg == "-m")
        .and_then(|pos| args.get(pos + 1))
        .and_then(|val| val.parse().ok())
        .unwrap_or(60);
    println!("Max duration is set to {}", max_duration);

    println!("Enter the comma-separated list of song durations:");
    let mut input = String::new();
    io::stdin().read_line(&mut input)
        .with_context(|_| "Failed to read from stdin")?;
    let durations: Vec<i32> = input
        .trim()
        .split(',')
        .filter_map(|s| s.trim().parse().ok())
        .collect();
    println!("Song durations: {:?}", durations);

    let result = gaffer::ffd(durations, max_duration);
    println!("Playlists (by FDD): {:?}", result);
    Ok(())
}
```

lib.rs:

```rust
//! algorithms for grouping audio files into playlists
//!

/// This function implements the First Fit Decreasing (FFD) algorithm to group audio files
pub fn ffd(durations: Vec<i32>, max_duration: i32) -> Vec<Vec<i32>> {
  let mut result: Vec<Vec<i32>> = Vec::new();
  let mut sorted_durations = durations.clone();
  sorted_durations.sort_by(|a, b| b.cmp(a));
  for duration in sorted_durations {
      let mut added = false;
      for group in &mut result {
          let total: i32 = group.iter().sum();
          if total + duration <= max_duration {
              group.push(duration);
              added = true;
              break;
          }
      }
      if !added {
          result.push(vec![duration]);
      }
  }
  result
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn ffd_works_with_example1() {
        assert_eq!(ffd(vec![120, 90, 60, 150, 80], 200),
            vec![vec![150], vec![120, 80], vec![90, 60]]
        );
    }

    #[test]
    fn ffd_works_with_example2() {
        assert_eq!(ffd(vec![120, 90, 60, 150, 80], 160),
            vec![vec![150], vec![120], vec![90,60], vec![80]]
        );
    }

    #[test]
    fn ffd_handles_songs_longer_than_playlist() {
        assert_eq!(ffd(vec![120, 90, 60, 150, 80], 140),
            vec![vec![150], vec![120], vec![90], vec![80, 60]]
        );
    }
}
```

## Credits and References

* [interview question of the week (2025-08-11)](https://buttondown.com/cassidoo/archive/new-sentences-have-appeared-on-earth-not-written/)
* [Bin packing problem](https://en.wikipedia.org/wiki/Bin_packing_problem)
* [First Fit Decreasing (FFD)](https://en.wikipedia.org/wiki/First-fit-decreasing_bin_packing)
* [Best Fit Decreasing (BFD)](https://en.wikipedia.org/wiki/Best-fit_bin_packing)
* [Longest-processing-time-first scheduling](https://en.wikipedia.org/wiki/Longest-processing-time-first_scheduling)
