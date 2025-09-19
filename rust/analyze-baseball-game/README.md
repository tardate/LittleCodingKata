# #xxx Analyze a Baseball Game

Using rust to analyze a baseball game; cassidoo's interview question of the week (2025-09-15).
This was the day I advanced to consciously incompetent in the rules of baseball.

## Notes

The [interview question of the week (2025-09-15)](https://buttondown.com/cassidoo/archive/there-is-nothing-more-truly-artistic-than-to-love/)
asks us to analyze baseball stats in a 2-d array:

> You are given an array of arrays, where each inner array represents the runs scored by each team in an inning of a baseball game: [[home1, away1], [home2, away2], ...]. Write a function that returns an object with the total runs for each team, which innings each team led, and who won the game.
>
> Example:
>
> ```js
> const innings = [[1, 0], [2, 2], [0, 3], [4, 1]];
>
>
> > analyzeBaseballGame(innings)
> > {
>    homeTotal: 7,
>    awayTotal: 6,
>    homeLedInnings: [1, 2, 4],
>    awayLedInnings: [3],
>    winner: "home"
>  }
> ```

### A Diversion into the Rules of Baseball

As a citizen of the rest of the world in which baseball is not a major sport, I soon realised I needed a refresher to do this properly!
[Wikipedia](https://en.wikipedia.org/wiki/Baseball_scorekeeping) and ChatGPT to the rescue.. here's what learned:

In baseball, the winner is the team that scores more runs than the other team by the end of the game.

* A standard baseball game lasts nine innings
* Runs are scored when a player safely reaches home plate after touching all four bases in order (first, second, third, home).
* After nine innings, if one team has more runs, that team wins.

If the score is tied after nine innings, the game goes into extra innings until one team finishes an inning with more runs than the other, making them the winner. In MLB, there can normally be no "draw", however a draw is possible in some circumstances:

* weather-related
* some leagues and special matches may limit the number of extra innings

When counting home-led or away-led innings:

* You look at who was leading at the end of that inning (not just during).
* If the score is tied at the end of the inning, it is usually counted as neither home-led nor away-led — it’s just recorded as a tie for that frame.
* Some analyses will include a "Tied" category so you can see how many innings were tied, others just omit those from the count entirely.

#### Implications for the Implementation

* winner is determined by comparing homeTotal and awayTotal
* home-led or away-led innings are determined by comparing homeTotal and awayTotal at the end of the innings
* there's no constraint mentioned, so I'll assume draws are possible
* I'll also assume we ignore tied innings when calculating home-led/away-led

### Initial Implementation

Created a new app `cargo new bba`, structured it as follows:

* [main.rs](./bba/src/main.rs)
    * main controller
    * accepts innings stats, calls the implementation, prints the result
* [lib.rs](./bba/src/lib.rs)
    * implements the analysis function
    * I decided to go with conventional rust linting practices rather than follow the specification to the letter, hence snake-case `analyze_baseball_game()` instead of `analyzeBaseballGame()`.

In action, here's the result for the example provided:

```sh
$ cd bba
$ echo "[[1, 0], [2, 2], [0, 3], [4, 1]]" | cargo run
    Finished `dev` profile [unoptimized + debuginfo] target(s) in 0.00s
     Running `target/debug/bba`
Enter the array of innings result arrays i.e. [[home, away]]:
Given Innings: [[1, 0], [2, 2], [0, 3], [4, 1]]
Result:
{
  "awayLedInnings": [
    3
  ],
  "awayTotal": 6,
  "homeLedInnings": [
    1,
    2,
    4
  ],
  "homeTotal": 7,
  "winner": "home"
}
```

I'm using [serde_json](https://docs.rs/serde_json/latest/serde_json/) to parse the input and pretty-print
the results, however this means that the order and styling of the output values are determined by the internal implementation.
Since sequence and formatting should not be significant for JSON, I'm going to just go with the flow and accept this variation from the example.

Here's another example using a full 9-innings set of results:

```sh
$ echo "[[1, 0], [2, 5], [0, 3], [4, 1], [1, 0], [2, 5], [0, 3], [4, 1], [0, 0]]" | cargo run
    Finished `dev` profile [unoptimized + debuginfo] target(s) in 0.01s
     Running `target/debug/bba`
Enter the array of innings result arrays i.e. [[home, away]]:
Given Innings: [[1, 0], [2, 5], [0, 3], [4, 1], [1, 0], [2, 5], [0, 3], [4, 1], [0, 0]]
Result:
{
  "awayLedInnings": [
    2,
    3,
    4,
    5,
    6,
    7,
    8,
    9
  ],
  "awayTotal": 18,
  "homeLedInnings": [
    1
  ],
  "homeTotal": 14,
  "winner": "away"
}
```

### Tests

I've added some basic unit tests for the main algorithm:

```sh
$ cargo test
    Finished `test` profile [unoptimized + debuginfo] target(s) in 0.01s
     Running unittests src/lib.rs (target/debug/deps/bba-ba471bff2c56bc4c)

running 4 tests
test tests::test_away_wins ... ok
test tests::test_home_wins ... ok
test tests::test_example ... ok
test tests::test_draw ... ok

test result: ok. 4 passed; 0 failed; 0 ignored; 0 measured; 0 filtered out; finished in 0.00s

     Running unittests src/main.rs (target/debug/deps/bba-698f36f01158bdfe)

running 0 tests

test result: ok. 0 passed; 0 failed; 0 ignored; 0 measured; 0 filtered out; finished in 0.00s

   Doc-tests bba

running 0 tests

test result: ok. 0 passed; 0 failed; 0 ignored; 0 measured; 0 filtered out; finished in 0.00s
```

### Example Code

[bba/src/main.rs](./bba/src/main.rs):

```rust
use exitfailure::ExitFailure;
use failure::ResultExt;
use std::io;

use bba::analyze_baseball_game;

fn main() -> Result<(), ExitFailure> {
    println!("Enter the array of innings result arrays i.e. [[home, away]]:");
    let mut input = String::new();
    io::stdin().read_line(&mut input)
        .with_context(|_| "Failed to read from stdin")?;
    let innings: Vec<Vec<i32>> = serde_json::from_str(&input.trim())
        .with_context(|_| "Failed to parse innings as JSON array of integer pairs")?;
    println!("Given Innings: {:?}", innings);

    let ffd_result = analyze_baseball_game(&innings);
    println!("Result:\n{}", serde_json::to_string_pretty(&ffd_result).unwrap());

    Ok(())
}
```

[bba/src/lib.rs](./bba/src/lib.rs):

```rust
//! algorithms for analyzing a baseball game
//!
use serde_json::json;

/// This function implements a basic analysis of a baseball game given the innings results
pub fn analyze_baseball_game(innings: &Vec<Vec<i32>>) -> serde_json::Value {
    let mut home_total = 0;
    let mut away_total = 0;
    let mut home_led_innings = Vec::new();
    let mut away_led_innings = Vec::new();

    for (i, inning) in innings.iter().enumerate() {
        if inning.len() != 2 {
            continue;
        }
        home_total += inning[0];
        away_total += inning[1];
        if away_total > home_total {
            away_led_innings.push(i + 1);
        } else if home_total > away_total {
            home_led_innings.push(i + 1);
        }
    }

    let winner = if home_total > away_total {
        "home"
    } else if away_total > home_total {
        "away"
    } else {
        "draw"
    };

    json!({
        "homeTotal": home_total,
        "awayTotal": away_total,
        "homeLedInnings": home_led_innings,
        "awayLedInnings": away_led_innings,
        "winner": winner
    })
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_example() {
        assert_eq!(
            analyze_baseball_game(&vec![vec![1, 0], vec![2, 2], vec![0, 3], vec![4, 1]]),
            json!({
                "homeTotal": 7,
                "awayTotal": 6,
                "homeLedInnings": [1, 2, 4],
                "awayLedInnings": [3],
                "winner": "home"
            })
        );
    }

    #[test]
    fn test_home_wins() {
        assert_eq!(
            analyze_baseball_game(
                &vec![
                    vec![0, 1], vec![7, 5], vec![4, 3], vec![1, 2],
                    vec![0, 1], vec![7, 5], vec![4, 3], vec![1, 2], vec![0, 0]
                ]
            ),
            json!({
                "homeTotal": 24,
                "awayTotal": 22,
                "homeLedInnings": [2, 3, 4, 6, 7, 8, 9],
                "awayLedInnings": [1],
                "winner": "home"
            })
        );
    }


    #[test]
    fn test_away_wins() {
        assert_eq!(
            analyze_baseball_game(
                &vec![
                    vec![1, 0], vec![2, 5], vec![0, 3], vec![4, 1],
                    vec![1, 0], vec![2, 5], vec![0, 3], vec![4, 1], vec![0, 0]
                ]
            ),
            json!({
                "homeTotal": 14,
                "awayTotal": 18,
                "homeLedInnings": [1],
                "awayLedInnings": [2, 3, 4, 5, 6, 7, 8, 9],
                "winner": "away"
            })
        );
    }

    #[test]
    fn test_draw() {
        assert_eq!(
            analyze_baseball_game(
                &vec![
                    vec![1, 0], vec![2, 0], vec![2, 3], vec![0, 2],
                    vec![1, 0], vec![2, 0], vec![2, 3], vec![0, 2], vec![2, 2]
                ]
            ),
            json!({
                "homeTotal": 12,
                "awayTotal": 12,
                "homeLedInnings": [1, 2, 3, 5, 6, 7],
                "awayLedInnings": [],
                "winner": "draw"
            })
        );
    }

}
```

## Credits and References

* [cassidoo's interview question of the week (2025-09-15)](https://buttondown.com/cassidoo/archive/there-is-nothing-more-truly-artistic-than-to-love/)
* <https://docs.rs/serde_json/latest/serde_json/>
* <https://en.wikipedia.org/wiki/Baseball_scorekeeping>
