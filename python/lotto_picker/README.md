# #264 Picker - The Python Way

Using a lotto picker example to demonstrate random numbers and set operations the python way

## Notes

Picking numbers for a [lottery](https://en.wikipedia.org/wiki/Lottery)
is a simple demonstration of two language features:

* random number generation
* producing a unique set

This is a little demonstration of how to do this the python way.

See also:

* [ruby/lotto_picker](../../ruby/lotto_picker) - ruby version
* [rust/lotto_picker](../../rust/lotto_picker) - rust version

### Random Number Generation

The [random](https://docs.python.org/3/library/random.html) standard library provides a
pseudo-random number generator (PRNG), currently implemented as a
[Mersenne Twister](https://en.wikipedia.org/wiki/Mersenne_Twister)
with a period of `2**19937-1`.

The  `random.randint(a, b)` function
return a random integer N such that a <= N <= b.

    random.randint(1, 10)
     => 6

### Unique Sets

We need to pick a unique set of numbers i.e. no repeats. There are many ways of doing this.
Since we are picking from a continuous series, we can simplify things by just ensuring that the results set
does is unique i.e. does not contain an repeating elements.

This is perfect use of the [set](https://docs.python.org/3/library/stdtypes.html#set) library type.
The set class provides collection of unordered values with no duplicates.

    my_numbers = set()
     => {}
    my_numbers.add(5)
     => {5}
    my_numbers.add(5)
     => {5}

### The Example

See [lpickr.py](./lpickr.py).
The core routine uses
`randint` for random number generation and
`set` for unique result set

    def pick(number_count, upper_limit):
        if number_count > upper_limit:
            raise Exception('Upper limit must be >= the number to pick')

        random.seed()

        choices = set()
        while len(choices) < number_count:
            choices.add(random.randint(1, upper_limit))

        return sorted(list(choices))

### Using the Example

The [lpickr.py](./lpickr.py) script supports a simple command line to pick "n" numbers from 1 to a max number "m"

Call for instructions:

    $ ./lpickr.py ?
    Usage: python ./lpickr.py <number_to_pick> <max>
    e.g:

        python ./lpickr.py 6 40
        5, 6, 14, 28, 30, 38

Some sample runs:

    $ ./lpickr.py 3 10
    1, 6, 7
    $ ./lpickr.py 3 10
    1, 8, 10
    $ ./lpickr.py 3 10
    1, 4, 9
    $ ./lpickr.py 3 10
    1, 5, 7
    $ ./lpickr.py 7 49
    8, 16, 20, 29, 43, 46, 49

### Running the Tests

Some basic tests are included in [test_lpickr.py ](./test_lpickr.py )

    $ ./test_lpickr.py
    ....
    ----------------------------------------------------------------------
    Ran 4 tests in 0.035s

    OK

## Credits and References

* [random](https://docs.python.org/3/library/random.html)
* [set](https://docs.python.org/3/library/stdtypes.html#set)
* [Generating Random Data in Python](https://realpython.com/python-random/)
* [Lottery](https://en.wikipedia.org/wiki/Lottery)
* [Mersenne Twister](https://en.wikipedia.org/wiki/Mersenne_Twister)
