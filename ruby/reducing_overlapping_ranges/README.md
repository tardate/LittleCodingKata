# #157 Overlapping Ranges

Looking at solutions for how to aggregate a series of ranges while excluding any overlaps (e.g. set of date ranges)

## Notes

Here's the essential problem: given a set of ranges, calculate the net range coverage, excluding any overlap or duplication.
The specific case I have in mind is a set of date ranges and I need to calculate the total duration without duplication/double counting.

The Ruby [Range](https://ruby-doc.org/core-3.0.0/Range.html) class offers some tantilizing functions
such as `cover?`, and Rails adds some spice e.g. [`overlaps?`](https://api.rubyonrails.org/classes/Range.html#method-i-overlaps-3F),
but they don't get much closer to the goal.

[Overlap of a date with an array of date intervals](https://stackoverflow.com/questions/41634168/overlap-of-a-date-with-an-array-of-date-intervals) from stackoverflow is getting closer, and gave me a pointer to
the [range_operators](https://github.com/monocle/range_operators) that looks promising.

### A Naïve Algorithm

Here's the thinking:

* the data pairs are sorted by their first element
* then each subsquent pair will fall into one of three cases:
  * start after the last end item, so can be added to the result in full
  * end after the last end item, so the difference between the last end and the "new" end is added to the result
  * end before the end of the last item, so can be ignored (already covered)

And here's the implementation I used:

```
  def naive_calculation(data)
    data.sort_by { |pair| pair.first }.each_with_object(
      { duration: 0, last_end: 0 }
    ) do |pair, memo|
      if pair.first > memo[:last_end]
        memo[:duration] += pair.last - pair.first + 1
        memo[:last_end] = pair.last
      elsif pair.last > memo[:last_end]
        memo[:duration] += pair.last - memo[:last_end]
        memo[:last_end] = pair.last
      end
    end[:duration]
  end
```

This passes all the test cases I've thrown at it so far, and actually turns out to be relatively straight-forward.

### Using the Range Operators Gem

The [range_operators](https://github.com/monocle/range_operators) gem offers a  very useful method for this problem:
`rangify`. It reduces a set of ranges down to the smallest set of non-overlapping ranges.
e.g.

```
[5..10, 8..12, 6..8, 20..22].rangify
 => [5..12, 20..22]
```

So here's the equivalent algorithm. The `rangify` call is the core, surrounded:

* pre: convert the 2-D array into an array of ranges
* post: sum the sizes of the resulting ranges

```
  def range_operators_calculation(data)
    data.map do |pair|
      Range.new *pair
    end.rangify.collect(&:size).sum
  end
```

### Test Run

See [examples.rb](./examples.rb) for the implementation of both the naïve and range operators versions,
tested with a couple of different datasets. Executing the file runs the test suite:

```
$ ./examples.rb
Run options: --seed 32192

# Running:

....

Finished in 0.001889s, 2117.5228 runs/s, 2117.5228 assertions/s.

4 runs, 4 assertions, 0 failures, 0 errors, 0 skips
```

## Credits and References

* [Range](https://ruby-doc.org/core-3.0.0/Range.html)
* [range_operators gem](https://github.com/monocle/range_operators)
* [Overlap of a date with an array of date intervals](https://stackoverflow.com/questions/41634168/overlap-of-a-date-with-an-array-of-date-intervals) from stackoverflow
