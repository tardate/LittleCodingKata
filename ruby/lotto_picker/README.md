# #263 Picker - The Ruby Way

Using a lotto picker example to demonstrate random numbers and set operations the ruby way

## Notes

Picking numbers for a [lottery](https://en.wikipedia.org/wiki/Lottery)
is a simple demonstration of two language features:

* random number generation
* producing a unique set

This is a little demonstration of how to do this the ruby way.

See also:

* [python/lotto_picker](../../python/lotto_picker) - python version
* [rust/lotto_picker](../../rust/lotto_picker) - rust version


### Random Number Generation

The [Random](https://ruby-doc.org/core-3.0.0/Random.html) standard library provides a
pseudo-random number generator (PRNG), currently implemented as a modified
[Mersenne Twister](https://en.wikipedia.org/wiki/Mersenne_Twister)
with a period of `2**19937-1`.

This is exposed as [`Kernel#rand`](https://ruby-doc.org/core-2.4.0/Kernel.html#method-i-rand)
and [`Random#rand`](https://ruby-doc.org/core-2.4.0/Random.html#method-i-rand):

    Kernel.rand(10)
     => 5
    rand(10) # same as Kernel.rand
     => 6
    Random.new.rand(10)
     => 4

[SecureRandom](https://ruby-doc.org/stdlib-2.5.1/libdoc/securerandom/rdoc/SecureRandom.html)
also provides a random number genreator interface:

    SecureRandom.rand(10)
     => 7

How do these rate?

* `Random#rand` is better than `Kernel#rand` because forces a re-seeding of the PRNG
* `Random#rand` is a very good random number generator:
    * Mersenne Twister is a solid PRNG used by many, many, many languages and libraries.
    * It's much, much, much better than most system PRNGs.
* `SecureRandom#rand` isn't a better PRNG, but it is much more secure (i.e. hard to crack the seed or state of the random number generator). That matters for cryptographic purposes, but not really here as we are not concerned with security, just randomness.

So for the example, I'll use `Random#rand`.

### Unique Sets

We need to pick a unique set of numbers i.e. no repeats. There are many ways of doing this.
Since we are picking from a continuous series, we can simplify things by just ensuring that the results set
does is unique i.e. does not contain an repeating elements.

That can be done with [array#uniq!](https://ruby-doc.org/core-2.5.0/Array.html#method-i-uniq-21):

    my_numbers = []
     => []
    my_numbers << 5
     => [5]
    my_numbers <> 5
     => [5, 5]
    my_numbers.uniq!
     => [5]

There is an easier way using the [Set](https://ruby-doc.org/stdlib-2.7.1/libdoc/set/rdoc/Set.html) library.
I think this was added to ruby in one of the 2.x releases.
The Set class provides collection of unordered values with no duplicates.

    my_numbers = Set[]
     => #<Set: {}>
    my_numbers.add(5)
     => #<Set: {5}>
    my_numbers.add(5)
     => #<Set: {5}>

So for the example, I'll use `Set` for ensuring a unique results set.

### The Example

See [lpickr.rb](./lpickr.rb).
The core routine uses
`Random#rand` for random number generation and
[Set](https://ruby-doc.org/stdlib-2.7.1/libdoc/set/rdoc/Set.html) for unique result set

    def pick(number_count, upper_limit)
      raise 'Upper limit must be >= the number to pick' if number_count > upper_limit

      prng = Random.new

      choices = Set[]
      while choices.length < number_count do
        choices.add 1 + prng.rand(upper_limit)
      end
      choices.sort
    end

### Using the Example

The [lpickr.rb](./lpickr.rb) script supports a simple command line to pick "n" numbers from 1 to a max number "m"

Call for instructions:

    $ ./lpickr.rb ?
    Usage: ruby ./lpickr.rb <number_to_pick> <max>
    e.g:

      ruby ./lpickr.rb 6 40
      5, 6, 14, 28, 30, 38

Some sample runs:

    $ ./lpickr.rb 3 10
    1, 9, 10
    $ ./lpickr.rb 3 10
    2, 3, 4
    $ ./lpickr.rb 3 10
    4, 5, 9
    $ ./lpickr.rb 3 10
    4, 6, 7
    $ ./lpickr.rb 7 49
    1, 2, 18, 22, 29, 37, 49

### Running the Tests

Some basic tests are included in [test_lpickr.rb ](./test_lpickr.rb )

    $ ./test_lpickr.rb
    Run options: --seed 26915

    # Running:

    ....

    Finished in 0.006796s, 588.5815 runs/s, 30164.8031 assertions/s.

    4 runs, 205 assertions, 0 failures, 0 errors, 0 skips

## Credits and References

* [`Kernel#rand`](https://ruby-doc.org/core-2.4.0/Kernel.html#method-i-rand)
* [Random](https://ruby-doc.org/core-2.4.0/Random.html)
* [SecureRandom](https://ruby-doc.org/stdlib-2.5.1/libdoc/securerandom/rdoc/SecureRandom.html)
* [Set](https://ruby-doc.org/stdlib-2.7.1/libdoc/set/rdoc/Set.html)
* [Lottery](https://en.wikipedia.org/wiki/Lottery)
* [Mersenne Twister](https://en.wikipedia.org/wiki/Mersenne_Twister)
