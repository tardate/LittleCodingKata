# Elixir Basics

Exploring basic language features of Elixir

## Notes

A bunch of examples to test various basic Elixir language features.
Many of these are derived from examples in the Programming Elixir book.

The scope of each example file is pretty self-explanatory:

* `anonymous_functions_test.exs`
* `immutability_test.exs`
* `pattern_matching_test.exs`
* `strings_and_binaries_test.exs`

### Running the Examples

Scripts explicitly invoke [ExUnit](https://hexdocs.pm/ex_unit/ExUnit.html)

```
$ elixir anonymous_functions_test.exs
.

Finished in 0.04 seconds (0.04s on load, 0.00s on tests)
1 test, 0 failures

Randomized with seed 154704
$ elixir immutability_test.exs
.

Finished in 0.05 seconds (0.04s on load, 0.01s on tests)
1 test, 0 failures

Randomized with seed 943675
$ elixir pattern_matching_test.exs
warning: no clause will ever match
  pattern_matching_test.exs:42

warning: this check/guard will always yield the same result
  pattern_matching_test.exs:42

warning: no clause will ever match
  pattern_matching_test.exs:62

warning: this check/guard will always yield the same result
  pattern_matching_test.exs:62

........

Finished in 0.09 seconds (0.08s on load, 0.01s on tests)
8 tests, 0 failures

Randomized with seed 149233
$ elixir strings_and_binaries_test.exs
...........

Finished in 0.08 seconds (0.08s on load, 0.00s on tests)
11 tests, 0 failures

Randomized with seed 603375
```

## Credits and References

* [ExUnit](https://hexdocs.pm/ex_unit/ExUnit.html)
* [String](https://hexdocs.pm/elixir/String.html)
* [Programming Elixir](../programming_elixir) by Dave Thomas, pubished by The Pragmatic Bookshelf
