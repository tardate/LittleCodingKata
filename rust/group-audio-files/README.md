# #346 Group Audio Files

Using rust to organise songs into playlists; cassidoo's interview question of the week (2025-08-11).
Compares results from First Fit Decreasing (FFD) and Best Fit Decreasing (BFD) bin packing algorithms.

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

That works well. I'll leave it as is, but there are some optimizations that could be useful at scale, e.g.:

* maintain a running total for each bucket rather than recalculate on each visit

### Adding BFD

The Best Fit Decreasing (BFD) algorithm may not make any difference with the small example datasets, but let's do it anyway.

Here's an initial naïve implementation:

```rust
/// This function implements the Best Fit Decreasing (BFD) algorithm to group audio files
pub fn bfd(durations: &Vec<i32>, max_duration: i32) -> Vec<Vec<i32>> {
    let mut result: Vec<Vec<i32>> = Vec::new();
    let mut sorted_durations = durations.clone();
    sorted_durations.sort_by(|a, b| b.cmp(a));
    for duration in sorted_durations {
        let mut best_group_index: Option<usize> = None;
        let mut best_fit: i32 = max_duration + 1; // Initialize to a value larger than max_duration
        for (index, group) in result.iter_mut().enumerate() {
            let total: i32 = group.iter().sum();
            if total + duration <= max_duration && (max_duration - (total + duration)) < best_fit {
                best_fit = max_duration - (total + duration);
                best_group_index = Some(index);
            }
        }
        if let Some(index) = best_group_index {
            result[index].push(duration);
        } else {
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
Playlists (by BFD): [[150], [120, 80], [90, 60]]
$ echo "120, 90, 60, 150, 80" | target/debug/gaffer -m 160
Max duration is set to 160
Enter the comma-separated list of song durations:
Song durations: [120, 90, 60, 150, 80]
Playlists (by FDD): [[150], [120], [90, 60], [80]]
Playlists (by BFD): [[150], [120], [90, 60], [80]]
```

If song durations exceed playlist duration, they will still be scheduled:

```sh
$ echo "120, 90, 60, 150, 80" | target/debug/gaffer -m 140
Max duration is set to 140
Enter the comma-separated list of song durations:
Song durations: [120, 90, 60, 150, 80]
Playlists (by FDD): [[150], [120], [90], [80, 60]]
Playlists (by BFD): [[150], [120], [90], [80, 60]]
```

We can see that FDD and BFD are producing the same results with these examples.
So when would BFD produce a different result than FDD?

The situation is discussed in a paper by Richard E. Korf
[An Improved Algorithm for Optimal Bin Packing](https://www.ijcai.org/Proceedings/03/Papers/179.pdf).
One example:

Given the durations `[82, 43, 40, 15, 12, 6]` and a `maxDuration` of `100`:

Using FFD:

* The first bucket would take `82`, with `18` remaining.
* The next largest `43` cannot fit, so it goes into a new bucket 2, with `57` remaining.
* The next `40` fits in bucket 2, with `17` remaining.
* The next `15` fits in bucket 1, with `3` remaining.
* The next `12` fits in bucket 2, with `5` remaining.
* The next `6` cannot fit, so it goes into a new bucket 3

Resulting in 3 buckets: `[[82, 15], [43, 40, 12], [6]]``

Using BFD:

* The first bucket would take `82`, with `18` remaining.
* The next largest `43` cannot fit, so it goes into a new bucket 2, with `57` remaining.
* The next `40` fits in bucket 2, with `17` remaining.
* The next `15` best fits in bucket 2, with `2` remaining.
* The next `12` fits in bucket 1, with `6` remaining.
* The next `6` fits in bucket 1, with `0` remaining.

Resulting in 2 buckets: `[[82, 12, 6], [43, 40, 15]]`

Thus, BFD can lead to fewer total playlists in certain scenarios.
And the code produces this result correctly:

```sh
$ echo "6, 12, 15, 40, 43, 82" | target/debug/gaffer -m 100
Max duration is set to 100
Enter the comma-separated list of song durations:
Song durations: [6, 12, 15, 40, 43, 82]
Playlists (by FDD): [[82, 15], [43, 40, 12], [6]]
Playlists (by BFD): [[82, 12, 6], [43, 40, 15]]
```

### Tests

I've added some basic unit tests for the main algorithm functions:

```sh
$ cargo test
    Finished `test` profile [unoptimized + debuginfo] target(s) in 0.05s
     Running unittests src/lib.rs (target/debug/deps/gaffer-39e94afbf3e080de)

running 8 tests
test tests::bfd_handles_songs_longer_than_playlist ... ok
test tests::bfd_works_with_example1 ... ok
test tests::ffd_handles_songs_longer_than_playlist ... ok
test tests::bfd_works_with_ffd_bfd_differential_example ... ok
test tests::ffd_works_with_example1 ... ok
test tests::bfd_works_with_example2 ... ok
test tests::ffd_works_with_example2 ... ok
test tests::ffd_works_with_ffd_bfd_differential_example ... ok

test result: ok. 8 passed; 0 failed; 0 ignored; 0 measured; 0 filtered out; finished in 0.00s

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
pub fn ffd(durations: &Vec<i32>, max_duration: i32) -> Vec<Vec<i32>> {
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

/// This function implements the Best Fit Decreasing (BFD) algorithm to group audio files
pub fn bfd(durations: &Vec<i32>, max_duration: i32) -> Vec<Vec<i32>> {
    let mut result: Vec<Vec<i32>> = Vec::new();
    let mut sorted_durations = durations.clone();
    sorted_durations.sort_by(|a, b| b.cmp(a));
    for duration in sorted_durations {
        let mut best_group_index: Option<usize> = None;
        let mut best_fit: i32 = max_duration + 1; // Initialize to a value larger than max_duration
        for (index, group) in result.iter_mut().enumerate() {
            let total: i32 = group.iter().sum();
            if total + duration <= max_duration && (max_duration - (total + duration)) < best_fit {
                best_fit = max_duration - (total + duration);
                best_group_index = Some(index);
            }
        }
        if let Some(index) = best_group_index {
            result[index].push(duration);
        } else {
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
        assert_eq!(
            ffd(&vec![120, 90, 60, 150, 80], 200),
            vec![vec![150], vec![120, 80], vec![90, 60]]
        );
    }

    #[test]
    fn ffd_works_with_example2() {
        assert_eq!(
            ffd(&vec![120, 90, 60, 150, 80], 160),
            vec![vec![150], vec![120], vec![90,60], vec![80]]
        );
    }

    #[test]
    fn ffd_handles_songs_longer_than_playlist() {
        assert_eq!(
            ffd(&vec![120, 90, 60, 150, 80], 140),
            vec![vec![150], vec![120], vec![90], vec![80, 60]]
        );
    }

    #[test]
    fn ffd_works_with_ffd_bfd_differential_example() {
        assert_eq!(
            ffd(&vec![82, 43, 40, 15, 12, 6], 100),
            vec![vec![82, 15], vec![43, 40, 12], vec![6]]
        );
    }


    #[test]
    fn bfd_works_with_example1() {
        assert_eq!(
            bfd(&vec![120, 90, 60, 150, 80], 200),
            vec![vec![150], vec![120, 80], vec![90, 60]]
        );
    }

    #[test]
    fn bfd_works_with_example2() {
        assert_eq!(
            bfd(&vec![120, 90, 60, 150, 80], 160),
            vec![vec![150], vec![120], vec![90,60], vec![80]]
        );
    }

    #[test]
    fn bfd_handles_songs_longer_than_playlist() {
        assert_eq!(
            bfd(&vec![120, 90, 60, 150, 80], 140),
            vec![vec![150], vec![120], vec![90], vec![80, 60]]
        );
    }

    #[test]
    fn bfd_works_with_ffd_bfd_differential_example() {
        assert_eq!(
            bfd(&vec![82, 43, 40, 15, 12, 6], 100),
            vec![vec![82, 12, 6], vec![43, 40, 15]]
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
* [An Improved Algorithm for Optimal Bin Packing](https://www.ijcai.org/Proceedings/03/Papers/179.pdf), Richard E. Korf
