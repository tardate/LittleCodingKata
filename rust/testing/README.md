# #104 Testing with Rust

How to write and organise tests for rust.

## Notes

Rust has first class testing support built into the language and toolchain.
It even has a [nascent style guide for testing](https://doc.rust-lang.org/1.0.0/style/testing/unit.html).

Test code is identified with a set of [test attributes](https://doc.rust-lang.org/reference/attributes/testing.html)

* `#[test]` marks a function as a test
* `#[ignore]` disables a test function
* `#[should_panic]` indicates a test is expected to generate a panic
* `#[cfg(test)]` is used to mark a testing module for conditional compilation when running in test mode

The test mode is enabled by passing the `--test` argument to `rustc` or using `cargo test`.

Assertions are supported with a number of macros including:

* [assert!](https://doc.rust-lang.org/std/macro.assert.html)
* [assert_eq!](https://doc.rust-lang.org/std/macro.assert_eq.html)
* [assert_ne!](https://doc.rust-lang.org/std/macro.assert_ne.html)
* there are complementary `debug_*!` forms that are only enabled in non optimized builds by default

Where to put test code:

* Unit tests: convention is to create a test module named tests in each file
* Integration tests: included in a `tests` directory at the top level of the project directory, next to `src`
* [Doc Tests](https://doc.rust-lang.org/rustdoc/documentation-tests.html): executing documentation examples to make sure they still run

Other things to note about testing:

* Rust’s privacy rules allow you to test private functions

### Testing a Library

```sh
$ cargo new tested_lib --lib
     Created library `tested_lib` package
$ cd tested_lib/
```

Added a few examples/demonstrations to this project including:

* unit test module
* assertions
* expect panic in a test
* integration tests
* doc tests

Running the tests:

```sh
$ cargo test
   Compiling tested_lib v0.1.0 (.../rust/testing/tested_lib)
    Finished test [unoptimized + debuginfo] target(s) in 1.80s
     Running target/debug/deps/tested_lib-bd99122334aecbd7

running 3 tests
test tests::add_private_works ... ok
test tests::add_two_works ... ok
test tests::failing_test ... ok

test result: ok. 3 passed; 0 failed; 0 ignored; 0 measured; 0 filtered out

     Running target/debug/deps/integration_test-86734f87d5dcd2ce

running 1 test
test it_adds_two ... ok

test result: ok. 1 passed; 0 failed; 0 ignored; 0 measured; 0 filtered out

   Doc-tests tested_lib

running 1 test
test src/lib.rs - add_two (line 5) ... ok

test result: ok. 1 passed; 0 failed; 0 ignored; 0 measured; 0 filtered out
```

### Testing an Application

Integration tests for binary creates face a problem: they can't use functions from `src/main.rs`.
Solution:

* put functionality that needs integration testing in supporting library create so it can be tested
* unit test `src/main.rs`, or just make it so trivial that it doesn't need additional testing

```sh
$ cargo new tested_app
     Created binary (application) `tested_app` package
$ cd tested_app/
```

```sh
$ cargo test
   Compiling tested_app v0.1.0 (.../rust/testing/tested_app)
    Finished test [unoptimized + debuginfo] target(s) in 1.76s
     Running target/debug/deps/tested_app-6874ba1f641ef8b1

running 3 tests
test tests::add_private_works ... ok
test tests::add_two_works ... ok
test tests::failing_test ... ok

test result: ok. 3 passed; 0 failed; 0 ignored; 0 measured; 0 filtered out

     Running target/debug/deps/tested_app-893ff5312f83678e

running 0 tests

test result: ok. 0 passed; 0 failed; 0 ignored; 0 measured; 0 filtered out

     Running target/debug/deps/integration_test-8cd2670c773b8a51

running 1 test
test it_adds_two ... ok

test result: ok. 1 passed; 0 failed; 0 ignored; 0 measured; 0 filtered out

   Doc-tests tested_app

running 1 test
test src/lib.rs - add_two (line 5) ... ok

test result: ok. 1 passed; 0 failed; 0 ignored; 0 measured; 0 filtered out
```

Running the app:

```sh
$ cargo run
    Finished dev [unoptimized + debuginfo] target(s) in 0.01s
     Running `target/debug/tested_app`
Adding 2 to 2 = 4
```

## Credits and References

* [Writing Automated Tests](https://doc.rust-lang.org/stable/book/ch11-00-testing.html) - The Rust Programming Language
* [Rust basic attributes](https://doc.rust-lang.org/reference/attributes.html#built-in-attributes-index)
* [Rust test attributes](https://doc.rust-lang.org/reference/attributes/testing.html)
