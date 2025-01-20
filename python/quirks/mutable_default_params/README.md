# #060 Python quirks - mutable default params

python quirks and gotchas


## Notes

This is one of the classic gotchas detailed in the [python-guide](http://docs.python-guide.org/en/latest/writing/gotchas/#mutable-default-arguments).


Default arguments are a hugely common pattern for simplifying function calling requirements.
But because they so commonly used, it's quite a risk that problems like this lurk in the code we write:

```
def append_to(element, to=[]):
    to.append(element)
    return to
print append_to(1)
[1]
append_to(1)
[1, 1]
append_to(1)
[1, 1, 1]
```

wtf? What's worse, a unit tests that called the function once would think it's all green.

The problem here is that Python evaluates default parameters at the point the function is defined, not when it is called.
This is unlike most other languages like Ruby.

So every time the function is called and using default parameters, the function will get a reference to the same list
created when the function was defined.

A list is used here as an example, but this behaviour will be similar for any other type that is passed by reference.

A common fix is to set `None` as the default value, and correctly initialise the argument's default value within the function if it is None.

See [mutable_default_params.py](./mutable_default_params.py) for a test of the problem and the fix.

```
$ ./mutable_default_params.py
..
----------------------------------------------------------------------
Ran 2 tests in 0.000s

OK
```

## Credits and References
* [“Least Astonishment” in Python: The Mutable Default Argument](http://stackoverflow.com/questions/1132941/least-astonishment-in-python-the-mutable-default-argument) - related question on SO
* [Mutable Default Arguments](http://docs.python-guide.org/en/latest/writing/gotchas/#mutable-default-arguments) - python-guide
* [Common Gotchas](http://docs.python-guide.org/en/latest/writing/gotchas/) - python-guide

