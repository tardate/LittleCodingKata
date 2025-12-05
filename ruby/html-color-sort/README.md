# #xxx Sorting HTML Colors

Using ruby to sort HTML Colors; cassidoo's interview question of the week (2025-12-01).
But with one hand tied behind your back ... no built-in sorting methods allowed!

## Notes

The [interview question of the week (2025-12-01)](https://buttondown.com/cassidoo/archive/we-all-have-our-down-days-but-its-not-hard-to/)
is a simple sorting challenge: order the HTML color codes, but don't use any built-in sorting methods.

> There are 16 basic HTML Colors. Write a program to output them in ascending order by HEX value. Don't use any built-in sorting methods!
>
> Example output:
>
> ```text
> 000000
> 000080
> 0000FF
> 008000
> 008080
> 00FF00
> 00FFFF
> 800000
> 800080
> 808000
> 808080
> C0C0C0
> FF0000
> FF00FF
> FFFF00
> FFFFFF
> ```

## About HTML Color Codes

["HTML Color Codes" or "Web colors"](https://en.wikipedia.org/wiki/Web_colors) are colors used in displaying web pages.

Color are specified according to the intensity of its red, green and blue components, each represented by eight bits i.e. 24 bits in total, allowing 16,777,216 colors to be specified.
An optional 4th byte for alpha value (transparency) may also be used.

Colors are represented in one of 3 ways:

* an rgb triplet `rgb(1,2,3)`
* hexadecimal form `#010203`
* color names e.g. `Teal` (`#008080`). The HTML 4 spec defined 16 basic colors and an additional 124 extended colors that are supported by all browsers.

The [basic colors](https://en.wikipedia.org/wiki/Web_colors#Basic_colors)
are 16 colors defined in the HTML 4.01 specification, ratified in 1999.

These 16 were labeled as sRGB and included in the HTML 3.0 specification, which noted they were "the standard 16 colors supported with the Windows VGA palette."

## Thinking about the Problem

Since we are only concerned with the 16 basic colors, a pre-determined dataset, it's tempting to just hard code the result!

But let's not do that, as it spoils the fun.
I'll approach this from an agnostic perspective of handling any 16 hex strings, so the constraints I'll apply:

* input will be "any 16 hex strings"
    * although the example shows hex strings a simply 6 hex digits, I'll use that for output format, but assume the input could have leading `#`,`0x`
* result will return them in sorted order (still strings, not converted into numbers)

## First Solution

Let's "vibe" this first (without AI).
If I just go through the input list once, and create a result list by inserting each value before the first value that it is smaller than, we should end up wth a good result.

Like sorting letters into pigeon holes by postal code - so let's call this the "postman" algorithm.
NB: after further reading, I realise this algorithm is already known as [insertion sort](https://en.wikipedia.org/wiki/Insertion_sort).

Here's the basic implementation:

```ruby
  def postman
    result = []
    numeric_input.each do |new_item|
      inserted = false
      result.each_with_index do |item, index|
        if new_item < item
          result.insert(index, new_item)
          inserted = true
          break
        end
      end
      result << new_item unless inserted
    end
    as_hex_string_array result
  end
```

Does it work? Well, yes it seems to:

```sh
$ ./examples.rb "000003, 000001, 000004, 000002" postman
Using algorithm: postman
Input: ["000003", " 000001", " 000004", " 000002"]
Appended 000003 at the end
Inserted 000001 before 000003 at index 0
Appended 000004 at the end
Inserted 000002 before 000003 at index 1
Result: ["000001", "000002", "000003", "000004"]
```

And with the actual HTML color codes:

```sh
$ ./examples.rb "FFFF00, 000000, 000080, 800000, FFFFFF, 008000, 0000FF, 008080, 00FF00, 00FFFF, 800080, 808000, 808080, C0C0C0, FF0000, FF00FF" postman
Using algorithm: postman
Input: ["FFFF00", " 000000", " 000080", " 800000", " FFFFFF", " 008000", " 0000FF", " 008080", " 00FF00", " 00FFFF", " 800080", " 808000", " 808080", " C0C0C0", " FF0000", " FF00FF"]
Appended FFFF00 at the end
Inserted 000000 before FFFF00 at index 0
Inserted 000080 before FFFF00 at index 1
Inserted 800000 before FFFF00 at index 2
Appended FFFFFF at the end
Inserted 008000 before 800000 at index 2
Inserted 0000FF before 008000 at index 2
Inserted 008080 before 800000 at index 4
Inserted 00FF00 before 800000 at index 5
Inserted 00FFFF before 800000 at index 6
Inserted 800080 before FFFF00 at index 8
Inserted 808000 before FFFF00 at index 9
Inserted 808080 before FFFF00 at index 10
Inserted C0C0C0 before FFFF00 at index 11
Inserted FF0000 before FFFF00 at index 12
Inserted FF00FF before FFFF00 at index 13
Result: ["000000", "000080", "0000FF", "008000", "008080", "00FF00", "00FFFF", "800000", "800080", "808000", "808080", "C0C0C0", "FF0000", "FF00FF", "FFFF00", "FFFFFF"]
```

But is that efficient? Each insertion requires traversing the result array and performing an insert or append operation.

Let's add a benchmark with the [benchmark gem](https://rubygems.org/gems/benchmark), as specified in the [Gemfile](./Gemfile).
We're clocking about 130 iterations/sec when sorting lists with 1000 elements:

```sh
$ ./examples.rb '' benchmark
Benchmarking with array size: 1000
ruby 3.0.5p211 (2022-11-24 revision ba5cf0f7c5) [arm64-darwin23]
Warming up --------------------------------------
             postman    12.000 i/100ms
Calculating -------------------------------------
             postman    129.350 (± 3.9%) i/s    (7.73 ms/i) -    648.000 in   5.018421s
```

## Using a Well-known Known Algorithm

[Sorting](https://en.wikipedia.org/wiki/Sorting_algorithm) is perhaps one of the most studied facets of computer science,
so one would expect that we might be able to find better solutions.

My initial "postman" algorithm is actually an [Insertion sort](https://en.wikipedia.org/wiki/Insertion_sort).
Its worst case performance is `n^2`.

There are a class of sorting algorithms with a worst case performance is `n log(n)`, such as:

* [Merge sort](https://en.wikipedia.org/wiki/Merge_sort)
* [Timsort](https://en.wikipedia.org/wiki/Timsort)

Let's try an implementation of merge sort:

```ruby
def merge_sort_impl(array)
  return array if array.length <= 1

  mid = array.length / 2
  left = merge_sort_impl(array[0...mid])
  right = merge_sort_impl(array[mid..-1])

  merge(left, right)
end

def merge(left, right)
  result = []
  until left.empty? || right.empty?
    if left.first <= right.first
      result << left.shift
    else
      result << right.shift
    end
  end
  result + left + right
end
```

Does it work? yes:

```sh
$ ./examples.rb "000003, 000001, 000004, 000002" merge_sort
Using algorithm: merge_sort
Input: ["000003", " 000001", " 000004", " 000002"]
Result: ["000001", "000002", "000003", "000004"]
```

And with the actual HTML color codes:

```sh
$ ./examples.rb "FFFF00, 000000, 000080, 800000, FFFFFF, 008000, 0000FF, 008080, 00FF00, 00FFFF, 800080, 808000, 808080, C0C0C0, FF0000, FF00FF" merge_sort
Using algorithm: merge_sort
Input: ["FFFF00", " 000000", " 000080", " 800000", " FFFFFF", " 008000", " 0000FF", " 008080", " 00FF00", " 00FFFF", " 800080", " 808000", " 808080", " C0C0C0", " FF0000", " FF00FF"]
Result: ["000000", "000080", "0000FF", "008000", "008080", "00FF00", "00FFFF", "800000", "800080", "808000", "808080", "C0C0C0", "FF0000", "FF00FF", "FFFF00", "FFFFFF"]
```

So how does it compare on the 1000 item benchmark? Well, `merge_sort` is almost 10x faster than the insertion sort. Nice result!

```sh
$ ./examples.rb '' benchmark
Benchmarking with array size: 1000
ruby 3.0.5p211 (2022-11-24 revision ba5cf0f7c5) [arm64-darwin23]
Warming up --------------------------------------
             postman    12.000 i/100ms
          merge_sort   118.000 i/100ms
Calculating -------------------------------------
             postman    127.916 (± 0.0%) i/s    (7.82 ms/i) -    648.000 in   5.065881s
          merge_sort      1.175k (± 0.9%) i/s  (851.30 μs/i) -      5.900k in   5.023160s

Comparison:
          merge_sort:     1174.7 i/s
             postman:      127.9 i/s - 9.18x  slower
```

If we test with the much smaller list of 16 colors, `merge_sort` is still almost twice as fast as the insertion sort.

```sh
$ ./examples.rb '' benchmark 16
Benchmarking with array size: 16
ruby 3.0.5p211 (2022-11-24 revision ba5cf0f7c5) [arm64-darwin23]
Warming up --------------------------------------
             postman     6.463k i/100ms
          merge_sort    11.807k i/100ms
Calculating -------------------------------------
             postman     64.625k (± 1.1%) i/s   (15.47 μs/i) -    323.150k in   5.000977s
          merge_sort    118.146k (± 0.9%) i/s    (8.46 μs/i) -    602.157k in   5.097184s

Comparison:
          merge_sort:   118145.8 i/s
             postman:    64625.1 i/s - 1.83x  slower

```

### Tests

I've setup some validation in [test_examples.rb](./test_examples.rb):

```sh
$ ./test_examples.rb
Run options: --seed 58453

# Running:

..........

Finished in 0.000384s, 26041.6657 runs/s, 26041.6657 assertions/s.

10 runs, 10 assertions, 0 failures, 0 errors, 0 skips
```

### Example Code

Final code is in [examples.rb](./examples.rb):

```ruby
#!/usr/bin/env ruby

require 'benchmark/ips'

def merge_sort_impl(array)
  return array if array.length <= 1

  mid = array.length / 2
  left = merge_sort_impl(array[0...mid])
  right = merge_sort_impl(array[mid..-1])

  merge(left, right)
end

def merge(left, right)
  result = []
  until left.empty? || right.empty?
    if left.first <= right.first
      result << left.shift
    else
      result << right.shift
    end
  end
  result + left + right
end

class HexStringSorter
  attr_reader :input
  attr_reader :logging

  def initialize(input, logging = false)
    @input = input
    @logging = logging
  end

  def log(message)
    puts message if logging
  end

  def numeric_input
    @numeric_input ||= input.map { |s| s.to_s.strip.sub(/\A0x/i, '').sub(/\A#/, '').to_i(16) }
  end

  def as_hex_string_array(result)
    result.map { |n| n.to_s(16).upcase.rjust(6, '0') }
  end

  def postman
    result = []
    numeric_input.each do |new_item|
      inserted = false
      result.each_with_index do |item, index|
        if new_item < item
          result.insert(index, new_item)
          inserted = true
          log("Inserted #{new_item.to_s(16).upcase.rjust(6, '0')} before #{item.to_s(16).upcase.rjust(6, '0')} at index #{index}")
          break
        end
      end
      unless inserted
        result << new_item
        log("Appended #{new_item.to_s(16).upcase.rjust(6, '0')} at the end")
      end
    end
    as_hex_string_array result
  end

  def merge_sort
    as_hex_string_array merge_sort_impl(numeric_input)
  end

  alias default merge_sort

  def benchmark(array_size)
    puts "Benchmarking with array size: #{array_size}"
    sample_data = Array.new(array_size) { |i| rand(0x1000000) }
    Benchmark.ips do |x|
      x.report('postman') do
        @numeric_input = sample_data.dup
        postman
      end
      x.report('merge_sort') do
        @numeric_input = sample_data.dup
        merge_sort
      end
      x.compare!
    end
  end
end

if __FILE__ == $PROGRAM_NAME
  (puts "Usage: ruby #{$0} (csv-list) (algorithm)"; exit) unless ARGV.length > 0
  input = ARGV[0].split(',')
  algorithm = ARGV[1] || 'default'
  if algorithm == 'benchmark'
    HexStringSorter.new(input).benchmark(ARGV[2] ? ARGV[2].to_i : 1000)
  else
    puts "Using algorithm: #{algorithm}"
    calculator = HexStringSorter.new(input, true)
    puts "Input: #{calculator.input.inspect}"
    puts "Result: #{calculator.send(algorithm)}"
  end
end
```

## Credits and References

* [cassidoo's interview question of the week (2025-12-01)](https://buttondown.com/cassidoo/archive/we-all-have-our-down-days-but-its-not-hard-to/)
* [Sorting algorithms](https://en.wikipedia.org/wiki/Sorting_algorithm)
* [benchmark gem](https://rubygems.org/gems/benchmark)
