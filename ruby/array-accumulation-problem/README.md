# #355 Array Accumulation Problem

Using ruby to solve the array accumulation problem; cassidoo's interview question of the week (2025-09-08).

## Notes

The [interview question of the week (2025-09-08)](https://buttondown.com/cassidoo/archive/lifes-too-short-to-be-a-pushover-kelly-clarkson/)
is an unusual way to sum an array with a moving window. But as in most cases, there's a naïve way to solve it, and sneakier ways:

> For an array of numbers, generate an array where for every element, all neighboring elements are added to itself, and return the sum of that array.
>
> Examples:
>
> ```js
> []               -> 0
> [1]              -> 1
> [1, 4]           -> 10 // (1+4 + 4+1)
> [1, 4, 7]        -> 28
> [1, 4, 7, 10]    -> 55
> [-1, -2, -3]     -> -14
> [0.1, 0.2, 0.3]  -> 1.4
> [1,-20,300,-4000,50000,-600000,7000000] -> 12338842
> ```

### Initial Approach

A naïve implementation literally scans the array and adds the values as requested:

```ruby
result = 0
input.each_with_index do |value, index|
  result += value
  result += input[index - 1] if index > 0
  result += input[index + 1] if index < input.length - 1
end
result
```

That works, of course, but there's a lot of array indexing going on.

Running some examples:

```sh
$ ./examples.rb "1, 4, 7"
Using algorithm: default
Input: [1, 4, 7]
Result: 28
$ ./examples.rb "0.1, 0.2, 0.3"
Using algorithm: default
Input: [0.1, 0.2, 0.3]
Result: 1.4
```

### Improving the Solution

Perhaps a smarter approach is to recognise that for arrays with more than one element:

* the first and last elements have 2x their value added
* all others have 3x their value added

A 1 element array just has its value added.

Let's try that:

```ruby
result = 0
last_index = input.length - 1
input.each_with_index do |value, index|
  multiplier = if last_index.zero?
    1
  elsif index.zero? || index == last_index
    2
  else
    3
  end
  result += value * multiplier
end
result
```

Also works. A few more lines, but more direct code.

Running some examples:

```sh
$ ./examples.rb "1, 4, 7" improved
Using algorithm: improved
Input: [1, 4, 7]
Result: 28
$ ./examples.rb "0.1, 0.2, 0.3" improved
Using algorithm: improved
Input: [0.1, 0.2, 0.3]
Result: 1.4
```

### Improved Algorithm

[Leyan Lo](https://bsky.app/profile/leyanlo.bsky.social/post/3lymgivx7i22p)
came up with an even cleaner restructuring of the solution: 3 times the sum, minus the first and last.

In ruby that can be a one-liner, implemented as algorithm `improved2a`:

```ruby
input.sum * 3 - (input.first || 0) - (input.last || 0)
```

However, this is subject to some strange results with floats:

```ruby
[0.1, 0.2, 0.3].sum * 3
 => 1.7999999999999998
```

Whereas tripling the individual items before summation produces a more sensible result:

```ruby
[0.1, 0.2, 0.3].inject(0) { |sum, n| sum + n * 3 }
 => 1.8
```

This is the solution in algorithm `improved2b`:

```ruby
def improved2b
  input.inject(0) { |sum, n| sum + n * 3 } - (input.first || 0) - (input.last || 0)
end
```

### Tests

I've setup some validation in [test_examples.rb](./test_examples.rb):

```sh
$ ./test_examples.rb
Run options: --seed 63991

# Running:

................................

Finished in 0.000462s, 69264.0687 runs/s, 71428.5709 assertions/s.

32 runs, 33 assertions, 0 failures, 0 errors, 0 skips
```

### Example Code

Final code is in [examples.rb](./examples.rb):

```ruby
#!/usr/bin/env ruby

class ArrayAccumulationProblem
  attr_reader :input

  def initialize(input)
    @input = input
  end

  def default
    result = 0
    input.each_with_index do |value, index|
      result += value
      result += input[index - 1] if index > 0
      result += input[index + 1] if index < input.length - 1
    end
    result
  end

  def improved
    result = 0
    last_index = input.length - 1
    input.each_with_index do |value, index|
      multiplier = if last_index.zero?
        1
      elsif index.zero? || index == last_index
        2
      else
        3
      end
      result += value * multiplier
    end
    result
  end

  def improved2a
    input.sum * 3 - (input.first || 0) - (input.last || 0)
  end

  def improved2b
    input.inject(0) { |sum, n| sum + n * 3 } - (input.first || 0) - (input.last || 0)
  end
end


if __FILE__==$PROGRAM_NAME
  (puts "Usage: ruby #{$0} (string) (algorithm)"; exit) unless ARGV.length > 0
  input = ARGV[0].split(',').map do |item|
    item.include?('.') ? item.to_f : item.to_i
  end
  algorithm = ARGV[1] || 'default'
  puts "Using algorithm: #{algorithm}"
  calculator = ArrayAccumulationProblem.new(input)
  puts "Input: #{calculator.input}"
  puts "Result: #{calculator.send(algorithm)}"
end
```

## Credits and References

* [cassidoo's interview question of the week (2025-09-08)](https://buttondown.com/cassidoo/archive/lifes-too-short-to-be-a-pushover-kelly-clarkson/)
