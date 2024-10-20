# #265 Picker - The Rust Way

Using a lotto picker example to demonstrate random numbers and set operations the rust way

## Notes

Picking numbers for a [lottery](https://en.wikipedia.org/wiki/Lottery)
is a simple demonstration of two language features:

* random number generation
* producing a unique set

This is a little demonstration of how to do this the rust way.

See also:

* [python/lotto_picker](../../python/lotto_picker) - python version
* [ruby/lotto_picker](../../ruby/lotto_picker) - ruby version

### Random Number Generation

There are a bunch of options for random number generation in rust, including:

* [rand](https://crates.io/crates/rand)
* [fastrand](https://crates.io/crates/fastrand)
* [oorandom](https://crates.io/crates/oorandom) - also includes a good "buyers guide" to the alternatives

I'm just going to go with [rand](https://crates.io/crates/rand) for this example -
it is the most full-featured but also most complex to use.

The simplest and most direct method of sampling from a range is the
[`gen_range`](https://rust-random.github.io/rand/rand/trait.Rng.html#method.gen_range) function.
It returns a random value in the given range, and is what I'll use here.

The rand crate provides other options, such as using a
[Uniform distiribution](https://rust-random.github.io/rand/rand/distributions/struct.Uniform.html).

### Unique Sets

We need to pick a unique set of numbers i.e. no repeats. There are many ways of doing this.
Since we are picking from a continuous series, we can simplify things by just ensuring that the results set
does is unique i.e. does not contain an repeating elements.

This is good application for the [HashSet](https://doc.rust-lang.org/std/collections/struct.HashSet.html) collection type.

### The Example

See [lib.rs](./lpickr/src/lib.rs) for the core routine:

    use rand::Rng;
    use std::collections::HashSet;

    pub fn pick(number_count: usize, upper_limit: usize) -> HashSet<usize> {
        let mut rng = rand::thread_rng();
        let mut choices: HashSet<usize> = HashSet::new();

        while choices.len() < number_count {
            choices.insert(rng.gen_range(1..=upper_limit));
        };
        choices
    }

This returns a HashSet, so the [main.rs](./lpickr/src/main.rs) routine
uses itertools to sort and join as a comma-separated string:

    println!("{}", lpickr::pick(number_count, upper_limit).iter().sorted().format(", "));

### Building the Example

Just the standard way with cargo:

    cargo new lpickr
    cd lpickr
    # add code
    cargo build
    cargo test
    cargo run

### Using the Example

The lpickr program supports a simple command line to pick "n" numbers from 1 to a max number "m"

Call for instructions:

    $ cargo run ?
    # or after compilation:
    $ target/debug/lpickr ?
    Usage: lpickr <number_to_pick> <max>

Some sample runs:

    $ target/debug/lpickr 3 10
    4, 5, 7
    $ target/debug/lpickr 3 10
    4, 7, 9
    $ target/debug/lpickr 3 10
    1, 3, 8
    $ target/debug/lpickr 3 10
    3, 4, 7
    $ target/debug/lpickr 7 49
    14, 19, 25, 27, 35, 36, 40

### Running the Tests

Some basic tests are included in [test_lpickr.py ](./test_lpickr.py )

    $ cargo test
       Compiling lpickr v0.1.0
        Finished test [unoptimized + debuginfo] target(s) in 0.99s
         Running target/debug/deps/lpickr-91a691446e285203

    running 4 tests
    test tests::test_fails_if_ask_for_more_numbers_than_available ... ok
    test tests::test_empty_if_ask_for_zero ... ok
    test tests::test_returns_expected_number_of_numbers ... ok
    test tests::test_returns_all_numbers_within_range ... ok

    test result: ok. 4 passed; 0 failed; 0 ignored; 0 measured; 0 filtered out; finished in 0.00s

         Running target/debug/deps/lpickr-707b18c635ac93c3

    running 0 tests

    test result: ok. 0 passed; 0 failed; 0 ignored; 0 measured; 0 filtered out; finished in 0.00s

       Doc-tests lpickr

    running 0 tests

    test result: ok. 0 passed; 0 failed; 0 ignored; 0 measured; 0 filtered out; finished in 0.00s

## Credits and References

* [rand](https://crates.io/crates/rand)
* [HashSet](https://doc.rust-lang.org/std/collections/struct.HashSet.html)
* [itertools](https://docs.rs/itertools/latest/itertools/)
* [Lottery](https://en.wikipedia.org/wiki/Lottery)
* [Mersenne Twister](https://en.wikipedia.org/wiki/Mersenne_Twister)
