# #140 Methods

Comparing and testing various memoization methods and gems in Ruby.

## Notes

Memoization is an optimization technique for storing the results of expensive function calls and returning the cached result for the same inputs.
Adding memoization should ideally not change the object/function interface i.e. memoization can be added or removed without changing code that calls the
memoized method.

The [Memoization](https://en.wikipedia.org/wiki/Memoization) design pattern can be considered
a specific instance of the more elaborate [Memento](https://en.wikipedia.org/wiki/Memento_pattern) pattern from the classic
[Design Patterns](https://www.goodreads.com/book/show/9637515-design-patterns) collection.

### Running the Examples

The Gemfile specifies the gem requirements. `bundle install` as usual.

### Memoize by Hand

Memoization is particularly clean and easy to implement in Ruby.
In its simplest form, a method like the following can be used to wrap/redefine
any existing method with a simple in-memory hash cache:

```
def memoize(name)
  cache = {}

  (class<<self; self; end).send(:define_method, name) do |*args|
    unless cache.has_key?(args)
      cache[args] = super(*args)
    end
    cache[args]
  end
  cache
end
```

Running the [memoization_by_hand.rb](./memoization_by_hand.rb) example:

```
$ bundle exec ruby memoization_by_hand.rb
Usage: ruby memoization_by_hand.rb number_of_times_to_calc_factorial factorial_to_calc
  e.g. ruby memoization_by_hand.rb 10000 200

$ bundle exec ruby memoization_by_hand.rb 10000 200
                  user     system      total        real
without memoize  0.890000   0.010000   0.900000 (  0.900780)
with memoize  0.020000   0.000000   0.020000 (  0.022810)
```

### Memoize

The [memoize](https://github.com/djberg96/memoize) gem was early on the scene and the first I'd used.
It has since bee been retired. Per the repo:

> It has long been surpassed by other, better memoization gems like memoizable and memoist

It still works though! Running the [memoize_example.rb](./memoize_example.rb) example:

```
$ bundle exec ruby memoize_example.rb
Usage: ruby memoize_example.rb number_of_times_to_calc_factorial factorial_to_calc
  e.g. ruby memoize_example.rb 10000 200

$ bundle exec ruby memoize_example.rb 10000 200
                  user     system      total        real
without memoize  0.840000   0.010000   0.850000 (  0.846640)
with memoize  0.020000   0.000000   0.020000 (  0.020939)
```

### Memoist

[memoist](https://github.com/matthewrudy/memoist) is a stand-alone version of `ActiveSupport::Memoizable`,
extracted when it was retired from core `ActiveSupport`.

Running the [memoist_example.rb](./memoist_example.rb) example:

```
$ bundle exec ruby memoist_example.rb
Usage: ruby memoist_example.rb number_of_times_to_calc_factorial factorial_to_calc
  e.g. ruby memoist_example.rb 10000 200

$ bundle exec ruby memoist_example.rb 10000 200
                  user     system      total        real
without memoist  0.840000   0.010000   0.850000 (  0.841281)
with memoist  0.030000   0.000000   0.030000 (  0.026051)
```

### Others

Search for [other memoize gems](https://rubygems.org/search?utf8=%E2%9C%93&query=memoize) in rubygems.

**Memoizable**

No demo for [memoizable](https://github.com/dkubb/memoizable) as it has a number of limitations,
the most serious being that it can only memoize methods with an arity of 0 (i.e. no parameters)


## Credits and References

* [Memoization](https://en.wikipedia.org/wiki/Memoization) - wikipedia
* [Memento](https://en.wikipedia.org/wiki/Memento_pattern) - wikipedia
* [Design Patterns](https://www.goodreads.com/book/show/9637515-design-patterns) - goodreads
* [memoize](https://github.com/djberg96/memoize)
* [memoist](https://github.com/matthewrudy/memoist)
