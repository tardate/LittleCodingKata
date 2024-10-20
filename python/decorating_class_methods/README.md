# #062 Decorating Class Methods

Decorating class methods in Python is on the one hand no different than decorating a function.
But due to the minimalistic way that [classes](https://docs.python.org/2/tutorial/classes.html)
are implemented, performing class-specific operations within a decorator requires a bit of work.

## Handling self and Arbitrary Parameters

Essentially, all that is required to decorate classes is to explicitly expect `self` as the first argument to the function.

I you don't really care about the `self` reference inside the decorator, then it is sufficient to define the decorator function
to expect arbitrary arguments:

    def decorator(func):
        def wrapper(*args):
            return func(*args)
        return wrapper

In the example, I'm explicitly expecting `self` so I can easily do things with it in the decorator:

    def method_wrapper(func):
        def wrapper(self, *args, **kwargs):
            return func(self, *args, **kwargs)
        return wrapper


## Allowing Introspection of Decorated Functions

Decorating a function has an unfortunate side-effect that details of the original function
are lost for introspection. This includes the fact that `__doc__` and `__name__` now return
values for the decorator function, not the original method.

Sometimes this may not matter, but sometimes it really does. For example, if you are using
[django-rest-swagger](https://github.com/marcgibbons/django-rest-swagger),
then decorators can break it's ability to gereate swagger documantation from your API methods.

Fortunately, [functools.wraps](https://docs.python.org/2/library/functools.html#functools.wraps) provides
a simple fix. It restores the `__doc__` and `__name__` methods to return details form the original function.

It just requires a decorator for the decorator(!)..

    from functools import wraps
    def method_wrapper(func):
        @wraps(func)
        def wrapper(self, *args, **kwargs):
            return func(self, *args, **kwargs)
        return wrapper

This behaviour is demonstrated in the example script (both the broken and fixed).


## The Example

The [demonstrator.py](./demonstrator.py) script shows techniques for decorating class methods with arbitrary parameters.
The [test_demonstrator.py](./test_demonstrator.py) exercises the decorators and highlights some issues and work-arounds.

## Running the Example

The output is a bit hard to read, but it provides a detailed log of what happens when calling two decorated methods.

```
$ ./demonstrator.py
INFO:demonstrator:method_wrapper.before: Demonstrator.apples called with args: ([], 'a message to apples') kwargs: {'example_id': 33}
INFO:demonstrator:running apples with payload: [], message: 'a message to apples', example_id: 33
INFO:demonstrator:method_wrapper.after: returns ['a message to apples', 33]
apples() returned ['a message to apples', 33]
INFO:demonstrator:wrapped_method_wrapper.before: Demonstrator.oranges called with args: ([], 'a message to oranges') kwargs: {'example_id': 33}
INFO:demonstrator:running oranges with payload: [], message: 'a message to oranges', example_id: 33
INFO:demonstrator:wrapped_method_wrapper.after: returns ['a message to oranges', 33]
oranges() returned ['a message to oranges', 33]
```

### Tests

The tests verify the functionality, and also prove the effect of `functools.wraps`.

The tests use the [mock](https://pypi.python.org/pypi/mock) package.
If you don't already have it installed, can install with the `requirements.txt` and pip:

    pip install -r requirements.txt

Running the tests...
NB: the expected failures are related to default `__name__` and `__doc__` behaviour tests.

```
$ ./test_demonstrator.py
...x..x...
----------------------------------------------------------------------
Ran 10 tests in 0.002s

OK (expected failures=2)
```

## Miscellaneous "Quite Interesting" Details in the Example

### How to inhibit logging in unit tests

The ambiguously-named
[logging.disable](https://docs.python.org/2/library/logging.html?highlight=logger#logging.disable)
actually overrides the log level.

Used in `setUp` and `tearDown`, it can be used to temporarily adjust the log level during tests:

    def setUp(self):
        logging.disable(logging.CRITICAL)

    def tearDown(self):
        logging.disable(logging.NOTSET)


### Expecting Failure

The [unittest.expectedFailure](https://docs.python.org/2.7/library/unittest.html#unittest.expectedFailure) decorator
can be used to mark tests that *will* fail.

It is used here to demonstrate how the decorator obscures method details. For example the docstring:

    @unittest.expectedFailure
    def test_apples_doc_is_available(self):
        self.assertEqual(
            ' Doc for apples(). ',
            self.instance.apples.__doc__
        )


## Credits and References
* [PEP 318 -- Decorators for Functions and Methods](https://www.python.org/dev/peps/pep-0318/)
* [PythonDecorators wiki](https://wiki.python.org/moin/PythonDecorators) - documents the history of the process of adding decorators to Python
* [Decorators](http://jfine-python-classes.readthedocs.io/en/latest/decorators.html) - from Python Classes by J Fine
* [functools.wraps](https://docs.python.org/2/library/functools.html#functools.wraps)
* [unittest.expectedFailure](https://docs.python.org/2.7/library/unittest.html#unittest.expectedFailure)
* [mock](https://pypi.python.org/pypi/mock)
* [How you implemented your Python decorator is wrong](http://blog.dscpl.com.au/2014/01/how-you-implemented-your-python.html)
