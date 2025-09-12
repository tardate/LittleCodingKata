# #356 Ruby 3.4

About Ruby 3.4 including installation on Apple Silicon.

## Notes

[Ruby 3.4](https://rubyreferences.github.io/rubychanges/3.4.html)
was [released on 2024-12-25](https://github.com/ruby/ruby/blob/ruby_3_4/NEWS.md).
As of 2025-07-15, [3.4.5](https://www.ruby-lang.org/en/news/2025/07/15/ruby-3-4-5-released/) is current stable.

Highlights

* Frozen string literals: strings will act as if they're frozen by default
* Default block parameter `it`: `[1, 2, 3].each { puts it }`
* Keyword splatting `nil`: Calling `**` on `nil` will be like calling `**` on an empty hash.
* `Array#fetch_values` was added, making the interface consistent with `Hash#fetch_values`
* `Hash.new` now accepts an optional `capacity:` argument, to preallocate the hash with a given capacity.
* `Range#size`: If the range that size is being called on is not iterable, Ruby will now throw a TypeError.
* `String#append_as_bytes` was added to more easily and efficiently work with binary buffers and protocols

### macOS (Apple Silicon) Install

```bash
$ rvm get head
...
$ rvm install ruby-3.4.5
...
ruby-3.4.5 - #generating default wrappers........
ruby-3.4.5 - #adjusting #shebangs for (gem irb erb ri rdoc testrb rake).
Install of ruby-3.4.5 - #complete
Ruby was built without documentation, to build it run: rvm docs generate-ri
```

Checking version installed:

```bash
$ ruby -v
ruby 3.4.5 (2025-07-16 revision 20cda200d3) +PRISM [arm64-darwin24]
```

## Testing Some of the Changes

See [examples.rb](./examples.rb) for a quick test of some of the changes.
Running the example:

```text
$ ./examples.rb
## Demo: Frozen String Literal
In Ruby 3.4, all string literals are frozen by default.
Example:
str = "Hello"; str.frozen? => true
Attempting to modify the string will raise an error:
Error: can't modify frozen String: "Hello"
## Demo: Default Block Parameter
In Ruby 3.4, you can use 'it' as a default block parameter.
Example: [1, 2, 3].each { puts it }
1
2
3
This simplifies numbered parameters introduced in Ruby 2.7: [1, 2, 3].each { puts _1 }
1
2
3
## Demo: Array#fetch_values
In Ruby 3.4, Array#fetch_values was added to fetch multiple values by index.
Array: ["a", "b", "c", "d", "e"]
Fetching values at indices 1, 3, and 4:
Fetched values: ["b", "d", "e"]
## Demo: Keyword Splatting Nil
In Ruby 3.4, splatting nil into keyword arguments is allowed.
Calling example_method(**nil) will not raise an error in Ruby 3.4:
Received keyword arguments: {}
## Demo: Hash.new with Capacity
In Ruby 3.4, you can create a hash with a specified initial capacity.
Example: hash = Hash.new(capacity: 10)
Created hash with capacity: {}
## Demo: Range Size on Non-Iterable Range
In Ruby 3.4, calling size on a range with non-iterable endpoints raises a TypeError.
Example (0.51..1.0).size
Error: can't iterate from Float
```

The [code](./examples.rb):

```ruby
#!/usr/bin/env ruby
# frozen_string_literal: true

def demo_frozen_string_literal
  puts "## Demo: Frozen String Literal"
  puts "In Ruby 3.4, all string literals are frozen by default."
  puts "Example:"
  str = "Hello"
  puts "str = #{str.inspect}; str.frozen? => #{str.frozen?}"
  puts "Attempting to modify the string will raise an error:"
  begin
    str << " World"
  rescue => e
    puts "Error: #{e.message}"
  end
end

def demo_default_block_parameter
  puts "## Demo: Default Block Parameter"
  puts "In Ruby 3.4, you can use 'it' as a default block parameter."
  puts "Example: [1, 2, 3].each { puts it }"
  [1, 2, 3].each { puts it }
  puts "This simplifies numbered parameters introduced in Ruby 2.7: [1, 2, 3].each { puts _1 }"
  [1, 2, 3].each { puts _1 }
end

def demo_array_fetch_values
  puts "## Demo: Array#fetch_values"
  puts "In Ruby 3.4, Array#fetch_values was added to fetch multiple values by index."
  arr = ['a', 'b', 'c', 'd', 'e']
  puts "Array: #{arr.inspect}"
  puts "Fetching values at indices 1, 3, and 4:"
  values = arr.fetch_values(1, 3, 4)
  puts "Fetched values: #{values.inspect}"
end

def demo_keyword_splatting_nil
  puts "## Demo: Keyword Splatting Nil"
  puts "In Ruby 3.4, splatting nil into keyword arguments is allowed."
  def example_method(**kwargs)
    puts "Received keyword arguments: #{kwargs}"
  end
  puts "Calling example_method(**nil) will not raise an error in Ruby 3.4:"
  example_method(**nil)
end

def demo_hash_new_capacity
  puts "## Demo: Hash.new with Capacity"
  puts "In Ruby 3.4, you can create a hash with a specified initial capacity."
  puts "Example: hash = Hash.new(capacity: 10)"
  hash = Hash.new(capacity: 10)
  puts "Created hash with capacity: #{hash.inspect}"
end

def demo_range_size_on_not_iterable_range
  puts "## Demo: Range Size on Non-Iterable Range"
  puts "In Ruby 3.4, calling size on a range with non-iterable endpoints raises a TypeError."
  begin
    puts "Example (0.51..1.0).size"
    puts (0.51..1.0).size
  rescue TypeError => e
    puts "Error: #{e.message}"
  end
end

demo_frozen_string_literal
demo_default_block_parameter
demo_array_fetch_values
demo_keyword_splatting_nil
demo_hash_new_capacity
demo_range_size_on_not_iterable_range
```

## Credits and References

* [NEWS for Ruby 3.4.0](https://github.com/ruby/ruby/blob/ruby_3_4/NEWS.md).
* [Ruby 3.4.5 Release News](https://www.ruby-lang.org/en/news/2025/07/15/ruby-3-4-5-released/)
* [About the Ruby 3.4 Release](https://rubyreferences.github.io/rubychanges/3.4.html)
* [What's new in Ruby 3.4](https://www.honeybadger.io/blog/ruby-3-4/)
