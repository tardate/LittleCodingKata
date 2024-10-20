# #061 Quirks - Late Bound Closures

Closures a great, but the results they produce depend on system state at the time they are called (not just when they are defined).


## Notes

This is one of the classic gotchas detailed in the [python-guide](http://docs.python-guide.org/en/latest/writing/gotchas/#late-binding-closures).

Here's a function that returns an array of lambdas that you might expect to mulitply the given
parameter by the poisiton in the list (i.e. the 0..4 produced by the range function):

```
def create_multipliers():
    return [lambda x : i * x for i in range(5)]
```

But in practice, it doesn't work correctly:

```
for multiplier in create_multipliers():
    print multiplier(2)
8
8
8
8
8
```

This occurs because `i` in the lambda is only evaluated when it is called (i.e. `print multiplier(2)`).
But by this time, the list comprehension has already been evaluated, `for i in range(5)` is over, and 'i' is 4.

A quick fix is to have the lambda bind immediately to its arguments:
```
def create_multipliers():
    return [lambda x, i=i : i * x for i in range(5)]
```

See [late_bound_closures.py](./late_bound_closures.py) for a test of the problem and the fix.

```
$ ./late_bound_closures.py
..
----------------------------------------------------------------------
Ran 2 tests in 0.000s

OK
```

## Examples

* [ref_params.py](./ref_params.py)
* [late_bound_closures.py](./late_bound_closures.py)

## Credits and References
* [Late Binding Closures](http://docs.python-guide.org/en/latest/writing/gotchas/#late-binding-closures) - python-guide
* [Common Gotchas](http://docs.python-guide.org/en/latest/writing/gotchas/) - python-guide
