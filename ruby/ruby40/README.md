# #398 Ruby 4.0

About Ruby 4.0 including installation on Apple Silicon.

## Notes

[Ruby 4.0](https://rubyreferences.github.io/rubychanges/4.0.html)
was [released on 2025-12-25](https://github.com/ruby/ruby/blob/v4.0.0/NEWS.md).
As of 2026-01-02, [4.0.0](https://www.ruby-lang.org/en/news/2025/12/25/ruby-4-0-0-released/) is current stable.

Highlights

* Logical binary operators (`||`, `&&`, `and` and `or`) at the beginning of a line continue the previous line, like fluent dot.
* More efficient Array find methods `Array#rfind`, `Array#find`
* `Net::HTTP` no longer auto-sets `Content-Type`.
* Set is now a core class and no longer needs to be autoloaded on use.
* Pathname has been promoted from a default gem to a core class of Ruby
* ZJIT is a new prototype JIT compiler. Isn't considered production ready yet, so it's behind a `--zjit` flag if you want to test it out.
* Ruby Box is an experimental isolation feature for separating definitions (monkey patches, globals, class definitions). It's akin to what you might call namespaces elsewhere
* Backtraces are cleaner, with internal frames hidden meaning C-implemented methods now show the Ruby source location.

### macOS (Apple Silicon) Install

Already available via [rvm](https://rvm.io/):

```bash
$ rvm get head
...
$ rvm install ruby-4.0.0
...
ruby-4.0.0 - #generating default wrappers........
ruby-4.0.0 - #adjusting #shebangs for (gem irb erb ri rdoc testrb rake).
Install of ruby-4.0.0 - #complete
Ruby was built without documentation, to build it run: rvm docs generate-ri
```

Checking version installed:

```sh
$ ruby -v
ruby 4.0.0 (2025-12-25 revision 553f1675f3) +PRISM [arm64-darwin24]
```

## Testing Some of the Changes

See [examples.rb](./examples.rb) for a quick test of some of the changes.
Running the example:

```sh
$ ruby examples.rb
## Demo: Logical binary operators
In Ruby 4.0, Logical binary operators (`||`, `&&`, `and` and `or`) at the beginning of a line continue the previous line, like fluent dot.
  Example:
    if condition1
      && condition2
      puts "OK!"
    end
OK!
## Demo: Infinite enumerator
In Ruby 4.0, `Enumerator.produce` now accepts an optional size keyword argument to specify the size of the enumerator
  Example:
    Enumerator.produce(1, size: Float::INFINITY, &:succ).size == Float::INFINITY
Infinity
## Demo: Finite enumerator with known/computable size
Example:
    required_items = 4
    traverser = Enumerator.produce(0, size: required_items) do |it|
      raise StopIteration if it == required_items - 1
      it + 1
    end
    traverser.each { |n| puts n }
traverser.size: 4
0
1
2
3
## Demo: Pathname
In Ruby 4.0, `Pathname` has been promoted from a default gem to a core class of Ruby
  Example:
    puts Pathname.new("../ruby40").basename
ruby40
```

## Credits and References

* [Ruby 4.0](https://rubyreferences.github.io/rubychanges/4.0.html)
* [NEWS for Ruby 4.0.0](https://github.com/ruby/ruby/blob/v4.0.0/NEWS.md)
* [Ruby 4.0.0 Released](https://www.ruby-lang.org/en/news/2025/12/25/ruby-4-0-0-released/)
* <https://rubyweekly.com/issues/781>
* <https://www.ruby-lang.org/en/news/2025/12/25/ruby-4-0-0-released/>
