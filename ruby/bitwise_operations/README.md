# #170 Bitwise Operations

All about bitwise operations in Ruby.

## Notes

### NOT

The [~](https://ruby-doc.org/core-2.5.0/Integer.html#method-i-~) operator: one's complement (returns a number where each bit is flipped)

By default, this returns a signed integer, so `~0b0101` produces `-0b110`. To convert to unsigned, `&` with `0xFFFF_FFFF`

### AND

The [&](https://ruby-doc.org/core-2.5.0/Integer.html#method-i-26) operator: Bitwise AND.

### OR

The [|](https://ruby-doc.org/core-2.5.0/Integer.html#method-i-7C) operator: Bitwise OR.

### XOR

The [^](https://ruby-doc.org/core-2.5.0/Integer.html#method-i-5E) operator: Bitwise EXCLUSIVE OR.

### Shift

The [<<](https://ruby-doc.org/core-2.5.0/Integer.html#method-i-3C-3C) operator: shift left.

The [>>](https://ruby-doc.org/core-2.5.0/Integer.html#method-i-3E-3E) operator: shift right.

### String Representation

The [to_s(base=10)](https://ruby-doc.org/core-2.5.0/Integer.html#method-i-to_s) method. `3.to_s(2) => "11"`

## Example Code

The [examples.rb](./examples.rb) file wraps up demonstrations of all these features in a set of tests.
Not very exciting to run!

```
$ ruby examples.rb
Run options: --seed 42933

# Running:

.......

Finished in 0.001204s, 5813.9542 runs/s, 6644.5191 assertions/s.

7 runs, 8 assertions, 0 failures, 0 errors, 0 skips
```

## Credits and References

* [Ruby's Bitwise Toolbox: Operators, Applications and Magic Tricks](https://www.honeybadger.io/blog/ruby-bitwise-operators/)
* [Ruby’s Bitwise Operators](https://www.calleluks.com/rubys-bitwise-operators/)
* [Ruby - Operators](https://www.tutorialspoint.com/ruby/ruby_operators.htm)
* [Bit Twiddling Hacks](http://graphics.stanford.edu/~seander/bithacks.html)
