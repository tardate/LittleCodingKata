# Regular Expressions and String Indexes

When string indexes are better than regex, and when regex can help writing a string index.

## Notes

The ruby String class overloads the `[]` operator with some interesting behaviours:

```
string[index] → new_string or nilclick to toggle source
string[start, length] → new_string or nil
string[range] → new_string or nil
string[regexp, capture = 0] → new_string or nil
string[substring] → new_string or nil
```

### Plain Text Search

Using `string[substring]` is a more efficient way of testing for substring than a regular expression

```
text = 'Plant a memory, plant a tree, do it today for tomorrow.'
# ok
text =~ /memory/
# better
text['memory']
```

### Using Regular Expressions as String Indexes

Using `string[regexp, capture = 0]` syntax allows matching and replacement in a string with a very simple syntax.

Getting content of a match:
```
text = 'Plant a memory, plant a tree, do it today for tomorrow.'
text[/pl.*ee/]
=> 'plant a tree'
```

Getting content of a captured group:

```
text = 'Plant a memory, plant a tree, do it today for tomorrow.'
text[/it\s(\w+)/, 1]
=> 'today'
```

Replacing content of a captured group:

```
text = 'Plant a memory, plant a tree, do it today for tomorrow.'
text[/it\s(\w+)/, 1] = 'now'
text
=> 'Plant a memory, plant a tree, do it now for tomorrow.'
```

### Running the Examples

See [examples.rb](./examples.rb); these demonstrations are written asa test suite:

```
$ ruby examples.rb
Run options: --seed 63700

# Running:

....

Finished in 0.001045s, 3827.7510 runs/s, 3827.7510 assertions/s.

4 runs, 4 assertions, 0 failures, 0 errors, 0 skips
```

## Credits and References

* [String `[]` operator](https://ruby-doc.org/core-3.0.0/String.html#method-i-5B-5D) - ruby-doc
* [Regular Expressions](https://rubystyle.guide/#regular-expressions) - Ruby Style Guide
