# #162 Loops in Rust

All about loops in rust

## Notes

Rust supports four loop expressions:

* A loop expression denotes an infinite loop.
* A while expression loops until a predicate is false.
* A while let expression tests a pattern.
* A for expression extracts values from an iterator, looping until the iterator is empty.

All four types of loop support break expressions, continue expressions, and labels. Only loop supports evaluation to non-trivial values.

### Loop

aka [Infinite loops](https://doc.rust-lang.org/reference/expressions/loop-expr.html#infinite-loops)

    loop {
        statements
    }

### While

aka [Predicate loops](https://doc.rust-lang.org/reference/expressions/loop-expr.html#predicate-loops)

    while condition {
        statements
    }

### While let

aka [Predicate pattern loops](https://doc.rust-lang.org/reference/expressions/loop-expr.html#predicate-pattern-loops)

    while let MatchArmPatterns = Expression {
        statements
    }

### For

aka [Iterator loops](https://doc.rust-lang.org/reference/expressions/loop-expr.html#iterator-loops)

    for Pattern in Expression {
        Statements
    }


### Running the Examples

Running the tests:

```
$ cargo test
   Compiling example v0.1.0 (.../LittleCodingKata/rust/loops/example)
    Finished test [unoptimized + debuginfo] target(s) in 0.43s
     Running target/debug/deps/example-3e96a7119aa2432d

running 5 tests
test tests::first_fib_for_works ... ok
test tests::first_fib_loop_with_return_value_works ... ok
test tests::first_fib_loop_works ... ok
test tests::first_fib_while_let_works ... ok
test tests::first_fib_while_works ... ok

test result: ok. 5 passed; 0 failed; 0 ignored; 0 measured; 0 filtered out

     Running target/debug/deps/example-362e95a34487a628

running 0 tests

test result: ok. 0 passed; 0 failed; 0 ignored; 0 measured; 0 filtered out

   Doc-tests example

running 0 tests

test result: ok. 0 passed; 0 failed; 0 ignored; 0 measured; 0 filtered out
```

Running the program:

```
$ cargo run
   Compiling example v0.1.0 (.../LittleCodingKata/rust/loops/example)
    Finished dev [unoptimized + debuginfo] target(s) in 0.19s
     Running `target/debug/example`
Loops in Rust
loop: first number in Fibonacci sequence over 10 = 13
loop_with_return_value: first number in Fibonacci sequence over 10 = 13
first_fib_while: first number in Fibonacci sequence over 10 = 13
first_fib_while_let: first number in Fibonacci sequence over 10 = 13
first_fib_for: first number in Fibonacci sequence over 10 = 13

```

## Credits and References

* [Loops](https://doc.rust-lang.org/reference/expressions/loop-expr.html) - Rust Reference
