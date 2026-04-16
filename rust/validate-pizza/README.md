# #xxx validatePizza

Using rust to validate a pizza recipe; cassidoo's interview question of the week (2026-04-13).

## Notes

The [interview question of the week (2026-04-13)](https://buttondown.com/cassidoo/archive/u1f9d1-u1f680-we-will-always-choose-earth-we-will/)
asks us to validate a pizza recipe:

> You're building a pizza ordering system that enforces strict ingredient layering rules. Given an array of pizza layers (bottom to top) and a set of rules where each rule states that ingredient A must appear somewhere below ingredient B, write a function that determines whether the pizza is valid. If any rule is violated, return the pair [A, B] that was violated first (in the order the rules are given). If the pizza is valid, return true.
>
> Examples:
>
> ```ts
> const layers = ["dough", "sauce", "cheese", "pepperoni", "basil"];
> const rules = [
>   ["sauce", "cheese"],
>   ["cheese", "pepperoni"],
>   ["dough", "basil"],
> ];
> const rules2 = [
>   ["cheese", "pepperoni"],
>   ["cheese", "sauce"], // "it's under the sauce"
> ];
>
> validatePizza(layers, rules);
> > true
>
> validatePizza(layers, rules2);
> > ['cheese', 'sauce']
> ```

## Thinking about the Problem

Rules are evaluated in order.

Each rule is a simple array indexing question:
if the index of ingredient A in the layers list is less than the index of ingredient B, then the rule is valid.

If all rules pass, return true, else return the first rule that failed.

## A first approach

The main program is a wrapper to read layers and rules from json files (given as file name parameters to the program).

The core function:

* iterates over the rules
* compares the indexes of the rule ingredients in the layers list
* if invalid, returns immediately with the invalid rule detail
* else returns true when all rules passed

```rust
pub fn validate_pizza(layers: &Vec<String>, rules: &Vec<Vec<String>>) -> String {
    for rule in rules {
      if rule.len() < 2 {
        continue;
      }
      let ingredient_a = &rule[0];
      let ingredient_b = &rule[1];

      if let (Some(index_a), Some(index_b)) = (
        layers.iter().position(|x| x == ingredient_a),
        layers.iter().position(|x| x == ingredient_b),
      ) {
        if index_a >= index_b {
          // return rule.join(",");
          return serde_json::to_string(&rule).unwrap();
        }
      }
    }
    "true".to_string()
}
```

Let's see how it goes:

```sh
$ cd perfectpizza
$ cat ../layers1.json
["dough", "sauce", "cheese", "pepperoni", "basil"]
$ cat ../rules1.json
[
  ["sauce", "cheese"],
  ["cheese", "pepperoni"],
  ["dough", "basil"]
]
$ cat ../rules2.json
[
  ["cheese", "pepperoni"],
  ["cheese", "sauce"]
]
$ cargo run -- ../layers1.json ../rules1.json
    Finished `dev` profile [unoptimized + debuginfo] target(s) in 0.01s
     Running `target/debug/perfectpizza ../layers1.json ../rules1.json`
Given layers : ["dough", "sauce", "cheese", "pepperoni", "basil"]
And rules    : [["sauce", "cheese"], ["cheese", "pepperoni"], ["dough", "basil"]]
Result: true
$ cargo run -- ../layers1.json ../rules2.json
    Finished `dev` profile [unoptimized + debuginfo] target(s) in 0.01s
     Running `target/debug/perfectpizza ../layers1.json ../rules2.json`
Given layers : ["dough", "sauce", "cheese", "pepperoni", "basil"]
And rules    : [["cheese", "pepperoni"], ["cheese", "sauce"]]
Result: ["cheese","sauce"]
```

### Tests

I've added some basic unit tests for the main algorithm:

```sh
$ cd perfectpizza
$ cargo test
    Finished `test` profile [unoptimized + debuginfo] target(s) in 0.01s
     Running unittests src/lib.rs (target/debug/deps/perfectpizza-8b60f6f01426c3c5)

running 2 tests
test tests::test_example2 ... ok
test tests::test_example1 ... ok

test result: ok. 2 passed; 0 failed; 0 ignored; 0 measured; 0 filtered out; finished in 0.00s

     Running unittests src/main.rs (target/debug/deps/perfectpizza-658a8b911ff375f5)

running 0 tests

test result: ok. 0 passed; 0 failed; 0 ignored; 0 measured; 0 filtered out; finished in 0.00s

   Doc-tests perfectpizza

running 0 tests

test result: ok. 0 passed; 0 failed; 0 ignored; 0 measured; 0 filtered out; finished in 0.00s
```

### Final Code

[perfectpizza/src/main.rs](./perfectpizza/src/main.rs):

```rust
use exitfailure::ExitFailure;
use failure::ResultExt;
use serde_json;

use perfectpizza::validate_pizza;

fn main() -> Result<(), ExitFailure> {
    let args: Vec<String> = std::env::args().collect();
    if args.len() != 3 {
        return Err(ExitFailure::from(
            failure::err_msg("Usage: perfectpizza <layers.json> <rules.json>")
        ));
    }

    let layers_str = std::fs::read_to_string(&args[1])
        .context(format!("Failed to read layers file: {}", args[1]))?;
    let layers: Vec<String> = serde_json::from_str(&layers_str)
        .context("Failed to parse layers JSON")?;
    let rules_str = std::fs::read_to_string(&args[2])
        .context(format!("Failed to read rules file: {}", args[2]))?;
    let rules: Vec<Vec<String>> = serde_json::from_str(&rules_str)
        .context("Failed to parse rules JSON")?;

    println!("Given layers : {:?}", layers);
    println!("And rules    : {:?}", rules);

    let result = validate_pizza(&layers, &rules);
    println!("Result: {}", result);

    Ok(())
}
```

[perfectpizza/src/lib.rs](./perfectpizza/src/lib.rs):

```rust
//! algorithms for validating a pizza recipe
//!
use serde_json;

/// This function implements the validation of pizza rules given a layers recipe.
pub fn validate_pizza(layers: &Vec<String>, rules: &Vec<Vec<String>>) -> String {
    for rule in rules {
      if rule.len() < 2 {
        continue;
      }
      let ingredient_a = &rule[0];
      let ingredient_b = &rule[1];

      if let (Some(index_a), Some(index_b)) = (
        layers.iter().position(|x| x == ingredient_a),
        layers.iter().position(|x| x == ingredient_b),
      ) {
        if index_a >= index_b {
          // return rule.join(",");
          return serde_json::to_string(&rule).unwrap();
        }
      }
    }
    "true".to_string()
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_example1() {
        assert_eq!(
            validate_pizza(
              &vec!["dough", "sauce", "cheese", "pepperoni", "basil"].iter().map(|s| s.to_string()).collect(),
              &vec![
                vec!["sauce", "cheese"].iter().map(|s| s.to_string()).collect(),
                vec!["cheese", "pepperoni"].iter().map(|s| s.to_string()).collect(),
                vec!["dough", "basil"].iter().map(|s| s.to_string()).collect(),
              ]
            ),
            "true"
        );
    }

    #[test]
    fn test_example2() {
        assert_eq!(
            validate_pizza(
              &vec!["dough", "sauce", "cheese", "pepperoni", "basil"].iter().map(|s| s.to_string()).collect(),
              &vec![
                vec!["cheese", "pepperoni"].iter().map(|s| s.to_string()).collect(),
                vec!["cheese", "sauce"].iter().map(|s| s.to_string()).collect(),
              ]
            ),
            "[\"cheese\",\"sauce\"]"
        );
    }
}
```

## Credits and References

* [cassidoo's interview question of the week (2026-04-13)](https://buttondown.com/cassidoo/archive/u1f9d1-u1f680-we-will-always-choose-earth-we-will/)
