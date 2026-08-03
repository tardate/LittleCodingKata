# #473 Reorder

Using ruby to reorder string arrays and compare algorithms: cassidoo's interview question of the week (2026-08-03).

## Notes

The [interview question of the week (2026-08-03)](https://buttondown.com/cassidoo/archive/u1f351-you-cant-suppress-the-things-that-make-us/):

> Given an array of strings A, and an array of indexes B, reorder the strings in array A with the given indices in array B. You can choose to do this in-place, or return a new array. As you decide which route to take, think... which is more efficient?
>
> Example:
>
> ```ts
> let a = ['C', 'D', 'E', 'F', 'G', 'H'];
> let b = [3, 0, 4, 1, 2, 5];
>
> > reorder(a, b) // a is now ['D', 'F', 'G', 'C', 'E', 'H']
> ```

### Thinking about the Problem

Key thing to note is that the sequence `b` gives the new position of the corresponding item in the source array.
i.e. **not** the source position for the output array.

### A Non-mutating Solution

This is a naïve solution: allocate the destination array, and then assign the items by plucking the corresponding source item:

```ruby
  def non_mutating
    result = Array.new(input.length)
    sequence.each_with_index do |item, index|
      result[item] = input[index]
    end
    result
  end
```

Does it work? Yes, it does the job:

```sh
$ ./challenge.rb
Usage: ruby ./challenge.rb <algorithm> <csv strings> <csv sequence>
$ ./challenge.rb non_mutating "C, D, E, F, G, H" "3, 0, 4, 1, 2, 5"
Using algorithm: non_mutating
input: ["C", "D", "E", "F", "G", "H"]
sequence: [3, 0, 4, 1, 2, 5]
Result: ["D", "F", "G", "C", "E", "H"]
```

How efficient is that? Well, in terms of memory, it has doubled the storage required.
But it is computationally quite efficient, and plays well in cases where you want to ensure immutable inputs.

### A Mutating Solution

Let's try a mutating solution. Computationally, this is more complex, as we need to keep track of the changing source positions.
Here's a simple approach that deletes and re-inserts items in the array:

```ruby
  def mutating_simple
    positions = (0...input.size).to_a

    sequence.each_with_index do |target, original|
      current = positions.index(original)
      next if current == target

      value = input.delete_at(current)
      input.insert(target, value)

      moved = positions.delete_at(current)
      positions.insert(target, moved)
    end

    input
  end
```

And it works:

```sh
$ ./challenge.rb mutating_simple "C, D, E, F, G, H" "3, 0, 4, 1, 2, 5"
Using algorithm: mutating_simple
input: ["C", "D", "E", "F", "G", "H"]
sequence: [3, 0, 4, 1, 2, 5]
Result: ["D", "F", "G", "C", "E", "H"]
```

### Improved Mutating Solution

Can we avoid all the memory re-allocation associated with deletes and inserts?
Yes, but it makes the tracking problem more complex to grasp.
Technically, this is a [Cyclic permutation algorithm](https://en.wikipedia.org/wiki/Cyclic_permutation).

```ruby
  def mutating_cyclic
    (0...input.length).each do |i|
      while sequence[i] != i
        j = sequence[i]

        input[i], input[j] = input[j], input[i]
        sequence[i], sequence[j] = sequence[j], sequence[i]
      end
    end

    input
  end
```

And it also works:

```sh
$ ./challenge.rb mutating_cyclic "C, D, E, F, G, H" "3, 0, 4, 1, 2, 5"
Using algorithm: mutating_cyclic
input: ["C", "D", "E", "F", "G", "H"]
sequence: [3, 0, 4, 1, 2, 5]
Result: ["D", "F", "G", "C", "E", "H"]
```

### How do they compare?

Running a benchmark using the [benchmark-ips](http://rubygems.org/gems/benchmark-ips) gem:

```sh
$ bundle install
...
$ ./challenge.rb benchmark
Benchmarking..
ruby 3.4.8 (2025-12-17 revision 995b59f666) +PRISM [arm64-darwin24]
Warming up --------------------------------------
        non_mutating   163.766k i/100ms
     mutating_simple    83.145k i/100ms
     mutating_cyclic   101.210k i/100ms
Calculating -------------------------------------
        non_mutating      1.630M (± 1.3%) i/s  (613.45 ns/i) -      8.188M in   5.023081s
     mutating_simple    826.517k (± 0.9%) i/s    (1.21 μs/i) -      4.157M in   5.029844s
     mutating_cyclic    996.538k (± 2.9%) i/s    (1.00 μs/i) -      5.060M in   5.078081s

Comparison:
   non_mutating:  1630135.0 i/s
mutating_cyclic:   996537.9 i/s - 1.64x  slower
mutating_simple:   826516.7 i/s - 1.97x  slower
```

So with Ruby, the simple non-mutating approach is clearly better, as long as you can spare the memory.
And as expected, the cyclic permutation approach beat out simple delete & insert.

### Tests

I've setup some validation in [test_challenge.rb](./test_challenge.rb):

```sh
 ./test_challenge.rb
Run options: --seed 25306

# Running:

....

Finished in 0.000994s, 4024.1449 runs/s, 4024.1449 assertions/s.

4 runs, 4 assertions, 0 failures, 0 errors, 0 skips
```

### Final Code

Final code is in [challenge.rb](./challenge.rb):

```ruby
#!/usr/bin/env ruby

require 'benchmark/ips'

class Reorder
  attr_accessor :input, :sequence

  def initialize(input, sequence)
    self.input = input
    self.sequence = sequence
  end

  def non_mutating
    result = Array.new(input.length, false)
    sequence.each_with_index do |target_index, source_index|
      result[target_index] = input[source_index]
    end
    result
  end

  alias default non_mutating

  def mutating_simple
    positions = (0...input.size).to_a

    sequence.each_with_index do |target, original|
      current = positions.index(original)
      next if current == target

      value = input.delete_at(current)
      input.insert(target, value)

      moved = positions.delete_at(current)
      positions.insert(target, moved)
    end

    input
  end

  def mutating_cyclic
    (0...input.length).each do |i|
      while sequence[i] != i
        j = sequence[i]

        input[i], input[j] = input[j], input[i]
        sequence[i], sequence[j] = sequence[j], sequence[i]
      end
    end

    input
  end


  def benchmark
    puts "Benchmarking.."
    sample_input = ['C', 'D', 'E', 'F', 'G', 'H']
    sample_sequence = [3, 0, 4, 1, 2, 5]

    Benchmark.ips do |x|
      x.report('non_mutating') do
        @input = sample_input.dup
        @sequence = sample_sequence.dup
        non_mutating
      end
      x.report('mutating_simple') do
        @input = sample_input.dup
        @sequence = sample_sequence.dup
        mutating_simple
      end
      x.report('mutating_cyclic') do
        @input = sample_input.dup
        @sequence = sample_sequence.dup
        mutating_cyclic
      end
      x.compare!
    end
  end
end


if __FILE__ == $PROGRAM_NAME
  algorithm = ARGV[0]
  if algorithm == 'benchmark'
    Reorder.new([], []).benchmark
  else
    (puts "Usage: ruby #{$0} <algorithm> <csv strings> <csv sequence>"; exit) unless ARGV.length == 3
    input = ARGV[1].split(',').map(&:strip)
    sequence = ARGV[2].split(',').map(&:to_i)
    puts "Using algorithm: #{algorithm}"
    calculator = Reorder.new(input, sequence)
    puts "input: #{calculator.input.inspect}"
    puts "sequence: #{calculator.sequence.inspect}"
    puts "Result: #{calculator.send(algorithm).inspect}"
  end
end

```

## Credits and References

* [cassidoo's interview question of the week (2026-08-03)](https://buttondown.com/cassidoo/archive/u1f351-you-cant-suppress-the-things-that-make-us/)
* [Cyclic permutation algorithm](https://en.wikipedia.org/wiki/Cyclic_permutation)
* [benchmark-ips](http://rubygems.org/gems/benchmark-ips)
