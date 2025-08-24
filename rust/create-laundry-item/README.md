# #347 Create Laundry Item

Using rust to implement a generator for a laundry object; cassidoo's interview question of the week (2025-08-11).
Rust does not encourage classic object-oriented patterns by default, but it can be used to model similar concepts with the struct keyword.

## Notes

The [interview question of the week (2025-08-18)](https://buttondown.com/cassidoo/archive/its-important-to-have-something-to-walk-towards/)
teases a classic object-oriented generator pattern:

> Write a generator function createLaundryItem() that returns an object representing a laundry item. This object should have a method nextCycle() which, when called, advances the item through a series of laundry cycles in order: "soak", "wash", "rinse", "spin", and "dry". After the final cycle, subsequent calls to nextCycle() should return "done".
>
> Example:
>
> ```js
> let towel = createLaundryItem();
>
> console.log(towel.nextCycle()); // "soak"
> console.log(towel.nextCycle()); // "wash"
> console.log(towel.nextCycle()); // "rinse"
> console.log(towel.nextCycle()); // "spin"
> console.log(towel.nextCycle()); // "dry"
> console.log(towel.nextCycle()); // "done"
> console.log(towel.nextCycle()); // "done"
> ```

### The Basic Approach

While rust is not inherently object-oriented, it does support OOP patterns with its [struct](https://doc.rust-lang.org/std/keyword.struct.html) support.

For example, we could model the `LaundryItem` as a [struct](https://doc.rust-lang.org/std/keyword.struct.html),
with a `LaundryState` [enum](https://doc.rust-lang.org/std/keyword.enum.html)
to track the current state,
and implement a public method `nextCycle` to handle state transition, returning the new state:

```rust
pub struct LaundryItem {
    cycle: LaundryState
}

impl LaundryItem {
    pub fn nextCycle(&mut self) -> String {
        ...
    }
}
```

As for tracking the state and managing state transitions, there are perhaps 3 main approaches:

1. Use an `enum` with a `next()` method, e.g.:

      ```rust
      enum State {
          Soak,
          Wash,
          Dry,
      }

      impl State {
          fn next(self) -> Option<Self> {
              use State::*;
              match self {
                  Soak => Some(Wash),
                  Wash => Some(Dry),
                  Dry => None, // reached the end
              }
          }
      }
      ```

2. Using `num_enum` for automatic numeric conversion, e.g.:

      ```rust
      use num_enum::{IntoPrimitive, TryFromPrimitive};

      #[derive(Debug, Clone, Copy, PartialEq, Eq, IntoPrimitive, TryFromPrimitive)]
      #[repr(u8)]
      enum State {
          Soak = 0,
          Wash = 1,
          Dry = 2,
      }

      impl State {
          fn next(self) -> Option<Self> {
              let value: u8 = self.into();
              Self::try_from(value + 1).ok()
          }
      }
      ```

3. Using strum for iteration

      ```rust
      use strum::IntoEnumIterator;
      use strum_macros::EnumIter;

      #[derive(Debug, EnumIter, Clone, Copy, PartialEq, Eq)]
      enum State {
          Start,
          Middle,
          End,
      }

      fn main() {
          for state in State::iter() {
              println!("{:?}", state);
          }
      }
      ```

### Initial Implementation

I decided to keep things simple with an `enum` to codify the possible states,
and hard-code the state transition rules in the `next()` method.

I've also decided to go with conventional rust linting practices rather than follow the specification to the letter, hence snake-case `create_laundry_item()` instead of `createLaundryItem()`, and `next_cycle()` instead of `nextCycle()`.

In action:

```sh
$ cd laundry
$ cargo run
    Finished `dev` profile [unoptimized + debuginfo] target(s) in 0.00s
     Running `target/debug/laundry`
soak
wash
rinse
spin
dry
done
done
```

### Tests

I've added some basic unit tests for the main algorithm functions:

```sh
$ cargo test
   Compiling laundry v0.1.0 (~/LittleCodingKata/rust/create-laundry-item/laundry)
    Finished `test` profile [unoptimized + debuginfo] target(s) in 0.10s
     Running unittests src/lib.rs (target/debug/deps/laundry-ad372ac221031815)

running 2 tests
test tests::create_laundry_item_returns_expected_object ... ok
test tests::create_laundry_next_cycle_transitions_states_correctly ... ok

test result: ok. 2 passed; 0 failed; 0 ignored; 0 measured; 0 filtered out; finished in 0.00s

     Running unittests src/main.rs (target/debug/deps/laundry-c662dc5c5fe8e1f1)

running 0 tests

test result: ok. 0 passed; 0 failed; 0 ignored; 0 measured; 0 filtered out; finished in 0.00s

   Doc-tests laundry

running 0 tests

test result: ok. 0 passed; 0 failed; 0 ignored; 0 measured; 0 filtered out; finished in 0.00s
```

### Example Code

Final code comprises:

* [laundry/src/main.rs](./laundry/src/main.rs) - handles main function
* [laundry/src/lib.rs](./laundry/src/lib.rs) - implements the `LaundryItem` class and related support

main.rs:

```rust
use laundry::create_laundry_item;

fn main() {
    let mut towel = create_laundry_item();

    println!("{}", towel.next_cycle());
    println!("{}", towel.next_cycle());
    println!("{}", towel.next_cycle());
    println!("{}", towel.next_cycle());
    println!("{}", towel.next_cycle());
    println!("{}", towel.next_cycle());
    println!("{}", towel.next_cycle());
}
```

lib.rs:

```rust
pub fn create_laundry_item() -> LaundryItem {
  LaundryItem {
    cycle: LaundryState::Ready
  }
}

#[derive(Debug)]
pub struct LaundryItem {
    cycle: LaundryState
}

impl LaundryItem {
    pub fn next_cycle(&mut self) -> String {
        self.cycle = match self.cycle  {
            LaundryState::Ready => LaundryState::Soak,
            LaundryState::Soak => LaundryState::Wash,
            LaundryState::Wash => LaundryState::Rinse,
            LaundryState::Rinse => LaundryState::Spin,
            LaundryState::Spin => LaundryState::Dry,
            LaundryState::Dry => LaundryState::Done,
            LaundryState::Done => LaundryState::Done
        };
        format!("{:?}", &self.cycle).to_lowercase()
    }
}

#[derive(Debug, PartialEq, Eq, Clone, Copy)]
enum LaundryState {
    Ready,
    Soak,
    Wash,
    Rinse,
    Spin,
    Dry,
    Done
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn create_laundry_item_returns_expected_object() {
        let obj = create_laundry_item();
        assert_eq!(obj.cycle, LaundryState::Ready);
    }

    #[test]
    fn create_laundry_next_cycle_transitions_states_correctly() {
        let mut obj = create_laundry_item();
        assert_eq!(obj.next_cycle(), "soak");
        assert_eq!(obj.next_cycle(), "wash");
        assert_eq!(obj.next_cycle(), "rinse");
        assert_eq!(obj.next_cycle(), "spin");
        assert_eq!(obj.next_cycle(), "dry");
        assert_eq!(obj.next_cycle(), "done");
        assert_eq!(obj.next_cycle(), "done");
        assert_eq!(obj.cycle, LaundryState::Done);
    }
}
```

## Credits and References

* [interview question of the week (2025-08-18)](https://buttondown.com/cassidoo/archive/its-important-to-have-something-to-walk-towards/)
