# #482 getSundays

Using rust to find all the Sundays in a given month; cassidoo's interview question of the week (2026-09-21).

## Notes

The [interview question of the week (2026-09-21)](https://buttondown.com/cassidoo/archive/u1f9d1-u1f3a8-always-make-room-for-the-unexpected/):

> Given a year and month, return an array containing every date in that month that falls on a Sunday. Return each date in YYYY-MM-DD format.
>
> Examples:
>
> ```ts
> > getSundays(2026, 9)
> > [ '2026-09-06', '2026-09-13', '2026-09-20', '2026-09-27' ]
>
> > getSundays(2024, 2)
> > [ '2024-02-04', '2024-02-11', '2024-02-18', '2024-02-25' ]
> ```

### Thinking about the Problem

Some basics:

* the month is specified as 1-based i.e. 1=Jan, 2=Feb etc
* lets assume modern Gregorian calendar and not deal with historical calendar adjustments

There are library functions for the hard parts. The [chrono crate](https://docs.rs/chrono/latest/chrono/index.html) has:

* [fn num_days](https://docs.rs/chrono/latest/chrono/enum.Month.html#method.num_days) - Get the length in days of the month.
* [fn weekday](https://docs.rs/chrono/latest/chrono/trait.Datelike.html#tymethod.weekday) - Returns the day of week.

Once we know how many days in a month, and how to find the first Sunday, then we can simple skip ahead in 7s.

But how do the library functions work?
Determining the number of [days in a month](https://en.wikipedia.org/wiki/Gregorian_calendar#Months) is normally a lookup with adjustment for leap years.
After a bit more research, I discovered
[Zeller's congruence](https://en.wikipedia.org/wiki/Zeller%27s_congruence)
which provides a relatively simple formula for calculating the day of the week for a given date.

### A First Go

Created a new app `cargo new challenge`, structured it as follows:

* [main.rs](./challenge/src/main.rs)
    * main controller
    * accepts year and month, calls the implementation, prints the resulting list of sundays
* [lib.rs](./challenge/src/lib.rs)
    * implements the core function
    * I decided to go with conventional rust linting practices rather than follow the specification to the letter, hence snake-case `get_sundays()` instead of `getSundays()`.

Let's first add the [chrono crate](https://docs.rs/chrono/latest/chrono/index.html) (`cargo add chrono`)
and use it to implement some `days_in_month` and `is_sunday` utility functions:

```rust
fn days_in_month_chrono(year: u32, month: u32) -> u32 {
    use chrono::Month;
    use std::convert::TryFrom;

    let m = Month::try_from(month as u8)
        .unwrap_or_else(|_| panic!("Invalid month: {}. Must be between 1 and 12.", month));

    m.num_days(year as i32)
        .unwrap_or_else(|| panic!("Invalid year provided: {}", year)) as u32
}

fn is_sunday_chrono(year: u32, month: u32, day: u32) -> bool {
    use chrono::NaiveDate;
    use chrono::Datelike;

    let date = NaiveDate::from_ymd_opt(year as i32, month, day).expect("Invalid date");
    date.weekday() == chrono::Weekday::Sun
}
```

To get all the Sundays in a month we just iterate the days and check for Sundays:

```rust
pub fn get_sundays(yyyy: u32, mm: u32) -> Vec<String> {
    let mut result = Vec::new();
    let mut day = 1;
    while day <= days_in_month_chrono(yyyy, mm) {
      if is_sunday_chrono(yyyy, mm, day) {
        result.push(format!("{:04}-{:02}-{:02}", yyyy, mm, day));
        day += 7;
      } else {
        day += 1;
      }
    }
    result
}
```

And that works nicely:

```sh
$ cargo run -- 2026 9
    Finished `dev` profile [unoptimized + debuginfo] target(s) in 00s
     Running `target/debug/challenge 2026 9`
["2026-09-06", "2026-09-13", "2026-09-20", "2026-09-27"]
$ cargo run -- 2024 2
    Finished `dev` profile [unoptimized + debuginfo] target(s) in 0.00s
     Running `target/debug/challenge 2024 2`
["2024-02-04", "2024-02-11", "2024-02-18", "2024-02-25"]
```

Now lets jettison the chrono crate and do things from scratch.
A `days_in_month` lookup function and `is_sunday` implementation of Zeller's congruence:

```rust
fn days_in_month(year: u32, month: u32) -> u32 {
    match month {
        1 | 3 | 5 | 7 | 8 | 10 | 12 => 31,
        4 | 6 | 9 | 11 => 30,
        2 => {
            if year % 4 == 0 && (year % 100 != 0 || year % 400 == 0) {
                29
            } else {
                28
            }
        }
        _ => panic!("Invalid month: {}. Must be between 1 and 12.", month),
    }
}

fn is_sunday_zeller(year: u32, month: u32, day: u32) -> bool {
    let mut y = year;
    let mut m = month;

    if m < 3 {
        m += 12;
        y -= 1;
    }

    let k = y % 100;
    let j = y / 100;

    let h = (day + (13 * (m + 1)) / 5 + k + k / 4 + j / 4 - 2 * j) % 7;

    h == 1
}
```

With `get_sundays` updated accordingly:

```rust
pub fn get_sundays(yyyy: u32, mm: u32) -> Vec<String> {
    let mut result = Vec::new();
    let mut day = 1;
    while day <= days_in_month(yyyy, mm) {
      if is_sunday_zeller(yyyy, mm, day) {
        result.push(format!("{:04}-{:02}-{:02}", yyyy, mm, day));
        day += 7;
      } else {
        day += 1;
      }
    }
    result
}
```

And it also works just fine:

```sh
$ cargo run -- 2026 9
    Finished `dev` profile [unoptimized + debuginfo] target(s) in 0.00s
     Running `target/debug/challenge 2026 9`
["2026-09-06", "2026-09-13", "2026-09-20", "2026-09-27"]
$ cargo run -- 2024 2
    Finished `dev` profile [unoptimized + debuginfo] target(s) in 0.00s
     Running `target/debug/challenge 2024 2`
["2024-02-04", "2024-02-11", "2024-02-18", "2024-02-25"]
```

### Tests

I've added some basic unit tests for the main algorithm and utility functions:

```sh
$ cargo test
    Finished `test` profile [unoptimized + debuginfo] target(s) in 0.00s
     Running unittests src/lib.rs (target/debug/deps/challenge-08a13c8fae894615)

running 12 tests
test tests::test_2026_dec ... ok
test tests::test_2026_feb ... ok
test tests::test_2026_jan ... ok
test tests::test_days_in_month ... ok
test tests::test_days_in_month_chrono ... ok
test tests::test_2026_mar ... ok
test tests::test_example1 ... ok
test tests::test_example2 ... ok
test tests::test_is_sunday_chrono ... ok
test tests::test_is_sunday_zeller ... ok
test tests::test_month_too_large - should panic ... ok
test tests::test_month_too_small - should panic ... ok

test result: ok. 12 passed; 0 failed; 0 ignored; 0 measured; 0 filtered out; finished in 0.00s

     Running unittests src/main.rs (target/debug/deps/challenge-640e22c5d1f61b7f)

running 0 tests

test result: ok. 0 passed; 0 failed; 0 ignored; 0 measured; 0 filtered out; finished in 0.00s

   Doc-tests challenge

running 0 tests

test result: ok. 0 passed; 0 failed; 0 ignored; 0 measured; 0 filtered out; finished in 0.00s
```

### Final Code

[main.rs](./challenge/src/main.rs)

```rust
use std::env;
use challenge;

fn main() {
    let args: Vec<String> = env::args().collect();
    if args.len() != 3 {
        eprintln!("Usage: {} <yyyy> <mm>", args[0]);
        std::process::exit(1);
    }
    let yyyy: u32 = args[1].parse().unwrap_or_else(|_| {
        eprintln!("Error: '{}' is not a valid integer", args[1]);
        std::process::exit(1);
    });
    let mm: u32 = args[2].parse().unwrap_or_else(|_| {
        eprintln!("Error: '{}' is not a valid integer", args[2]);
        std::process::exit(1);
    });
    let result = challenge::get_sundays(yyyy, mm);
    println!("{:?}", result);
}
```

[lib.rs](./challenge/src/lib.rs)

```rust
#[allow(dead_code)]
fn days_in_month(year: u32, month: u32) -> u32 {
    match month {
        1 | 3 | 5 | 7 | 8 | 10 | 12 => 31,
        4 | 6 | 9 | 11 => 30,
        2 => {
            if year % 4 == 0 && (year % 100 != 0 || year % 400 == 0) {
                29
            } else {
                28
            }
        }
        _ => panic!("Invalid month: {}. Must be between 1 and 12.", month),
    }
}

#[allow(dead_code)]
fn is_sunday_zeller(year: u32, month: u32, day: u32) -> bool {
    let mut y = year;
    let mut m = month;

    if m < 3 {
        m += 12;
        y -= 1;
    }

    let k = y % 100;
    let j = y / 100;

    let h = (day + (13 * (m + 1)) / 5 + k + k / 4 + j / 4 - 2 * j) % 7;

    h == 1
}

#[allow(dead_code)]
fn days_in_month_chrono(year: u32, month: u32) -> u32 {
    use chrono::Month;
    use std::convert::TryFrom;

    let m = Month::try_from(month as u8)
        .unwrap_or_else(|_| panic!("Invalid month: {}. Must be between 1 and 12.", month));

    m.num_days(year as i32)
        .unwrap_or_else(|| panic!("Invalid year provided: {}", year)) as u32
}

#[allow(dead_code)]
fn is_sunday_chrono(year: u32, month: u32, day: u32) -> bool {
    use chrono::NaiveDate;
    use chrono::Datelike;

    let date = NaiveDate::from_ymd_opt(year as i32, month, day).expect("Invalid date");
    date.weekday() == chrono::Weekday::Sun
}

pub fn get_sundays(yyyy: u32, mm: u32) -> Vec<String> {
    let mut result = Vec::new();
    let mut day = 1;
    while day <= days_in_month(yyyy, mm) {
      if is_sunday_zeller(yyyy, mm, day) {
        result.push(format!("{:04}-{:02}-{:02}", yyyy, mm, day));
        day += 7;
      } else {
        day += 1;
      }
    }
    result
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_days_in_month() {
        assert_eq!(days_in_month(2024, 2), 29);
        assert_eq!(days_in_month(2026, 2), 28);
        assert_eq!(days_in_month(2026, 9), 30);
        assert_eq!(days_in_month(2026, 12), 31);
    }

    #[test]
    fn test_is_sunday_zeller() {
        assert_eq!(is_sunday_zeller(2026, 1, 3), false);
        assert_eq!(is_sunday_zeller(2026, 1, 4), true);
        assert_eq!(is_sunday_zeller(2026, 1, 5), false);
        assert_eq!(is_sunday_zeller(2026, 9, 1), false);
        assert_eq!(is_sunday_zeller(2026, 9, 5), false);
        assert_eq!(is_sunday_zeller(2026, 9, 6), true);
        assert_eq!(is_sunday_zeller(2026, 9, 7), false);
        assert_eq!(is_sunday_zeller(2026, 9, 13), true);
        assert_eq!(is_sunday_zeller(2026, 9, 20), true);
        assert_eq!(is_sunday_zeller(2026, 9, 27), true);
    }

    #[test]
    fn test_days_in_month_chrono() {
        assert_eq!(days_in_month_chrono(2024, 2), 29);
        assert_eq!(days_in_month_chrono(2026, 2), 28);
        assert_eq!(days_in_month_chrono(2026, 9), 30);
        assert_eq!(days_in_month_chrono(2026, 12), 31);
    }

    #[test]
    fn test_is_sunday_chrono() {
        assert_eq!(is_sunday_chrono(2026, 1, 3), false);
        assert_eq!(is_sunday_chrono(2026, 1, 4), true);
        assert_eq!(is_sunday_chrono(2026, 1, 5), false);
        assert_eq!(is_sunday_chrono(2026, 9, 1), false);
        assert_eq!(is_sunday_chrono(2026, 9, 5), false);
        assert_eq!(is_sunday_chrono(2026, 9, 6), true);
        assert_eq!(is_sunday_chrono(2026, 9, 7), false);
        assert_eq!(is_sunday_chrono(2026, 9, 13), true);
        assert_eq!(is_sunday_chrono(2026, 9, 20), true);
        assert_eq!(is_sunday_chrono(2026, 9, 27), true);
    }

    #[test]
    fn test_example1() {
        assert_eq!(get_sundays(2026, 9), [ "2026-09-06", "2026-09-13", "2026-09-20", "2026-09-27" ]);
    }

    #[test]
    fn test_example2() {
        assert_eq!(get_sundays(2024, 2), [ "2024-02-04", "2024-02-11", "2024-02-18", "2024-02-25" ]);
    }

    #[test]
    fn test_2026_jan() {
        assert_eq!(get_sundays(2026, 1), [ "2026-01-04", "2026-01-11", "2026-01-18", "2026-01-25" ]);
    }

    #[test]
    fn test_2026_feb() {
        assert_eq!(get_sundays(2026, 2), [ "2026-02-01", "2026-02-08", "2026-02-15", "2026-02-22" ]);
    }

    #[test]
    fn test_2026_mar() {
        assert_eq!(get_sundays(2026, 3), [ "2026-03-01", "2026-03-08", "2026-03-15", "2026-03-22", "2026-03-29" ]);
    }

    #[test]
    fn test_2026_dec() {
        assert_eq!(get_sundays(2026, 12), [ "2026-12-06", "2026-12-13", "2026-12-20", "2026-12-27" ]);
    }

    #[test]
    #[should_panic]
    fn test_month_too_large() {
        get_sundays(2023, 13);
    }

    #[test]
    #[should_panic]
    fn test_month_too_small() {
        get_sundays(2023, 0);
    }
}
```

## Credits and References

* [cassidoo's interview question of the week (2026-09-21)](https://buttondown.com/cassidoo/archive/u1f9d1-u1f3a8-always-make-room-for-the-unexpected/)
* [Zeller's congruence](https://en.wikipedia.org/wiki/Zeller%27s_congruence)
* [Crate chrono](https://docs.rs/chrono/latest/chrono/index.html)
* [Crate chrono: fn num_days](https://docs.rs/chrono/latest/chrono/enum.Month.html#method.num_days)
* [Crate chrono: fn weekday](https://docs.rs/chrono/latest/chrono/trait.Datelike.html#tymethod.weekday)
