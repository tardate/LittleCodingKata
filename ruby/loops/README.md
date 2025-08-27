# #129 Ruby Loop

All the various ways of looping in Ruby.

## Notes

### for..in

The basic `for <variable> in <enumerable> <block>` structure is common, especially when iterating arbitrary ranges.

See [ruby doc: for loop](https://ruby-doc.org/core-2.6/doc/syntax/control_expressions_rdoc.html#label-for+Loop)

### each

When needing to iterate all items in a collection, the `<enumerable>.each <block>` structure is generally preferred.

See [ruby doc: Array#each](https://ruby-doc.org/core-2.6/Array.html#method-i-each)

### while

The `while <condition> <block>` structure is ideal for when the condition needs to be checked before any iteration.

See [ruby doc: while loop](https://ruby-doc.org/core-2.6/doc/syntax/control_expressions_rdoc.html#label-while+Loop)

### Until

The `until <condition> <block>` structure is similar to `while` except uses the complimentary condition.
The condition is checked before the block is executed.

See [ruby doc: until loop](https://ruby-doc.org/core-2.6/doc/syntax/control_expressions_rdoc.html#label-until+Loop)

### Loop

The `loop` syntax is a shortcut for an infinite `while true <block>` loop. A `break` condition would be used to exit the loop.
See [ruby doc: break](https://ruby-doc.org/core-2.6/doc/syntax/control_expressions_rdoc.html#label-break+Statement)

```ruby
loop do
  ...
  break if <cond>
end
```

### Unless/While Modifiers

An old,
[now discouraged (Re: semantics of if/unless/while statement modifiers)](http://blade.nagaokaut.ac.jp/cgi-bin/scat.rb/ruby/ruby-core/6745)
syntax is to apply a while/until modifier to a block.

[ruby doc: while/until modifiers](https://ruby-doc.org/core-2.6/doc/syntax/control_expressions_rdoc.html#label-Modifier+while+and+until)

Why discouraged? .. because it's hard for users to tell

```ruby
begin <code> end while <cond>
```

works differently from

```ruby
<code> while <cond>
```

### Running the Examples

See [examples.rb](./examples.rb); these demonstrations are written asa test suite:

```sh
$ ruby examples.rb
Run options: --seed 8730

# Running:

...........

Finished in 0.001201s, 9159.0354 runs/s, 9159.0354 assertions/s.

11 runs, 11 assertions, 0 failures, 0 errors, 0 skips
```

## Credits and References

* [ruby doc: for loop](https://ruby-doc.org/core-2.6/doc/syntax/control_expressions_rdoc.html#label-for+Loop)
* [ruby doc: Array#each](https://ruby-doc.org/core-2.6/Array.html#method-i-each)
* [ruby doc: while loop](https://ruby-doc.org/core-2.6/doc/syntax/control_expressions_rdoc.html#label-while+Loop)
* [ruby doc: until loop](https://ruby-doc.org/core-2.6/doc/syntax/control_expressions_rdoc.html#label-until+Loop)
* [ruby doc: break](https://ruby-doc.org/core-2.6/doc/syntax/control_expressions_rdoc.html#label-break+Statement)
* [ruby doc: next](https://ruby-doc.org/core-2.6/doc/syntax/control_expressions_rdoc.html#label-next+Statement)
* [ruby doc: redo](https://ruby-doc.org/core-2.6/doc/syntax/control_expressions_rdoc.html#label-redo+Statement)
* [ruby doc: while/until modifiers](https://ruby-doc.org/core-2.6/doc/syntax/control_expressions_rdoc.html#label-Modifier+while+and+until)
* [Re: semantics of if/unless/while statement modifiers](http://blade.nagaokaut.ac.jp/cgi-bin/scat.rb/ruby/ruby-core/6745)
