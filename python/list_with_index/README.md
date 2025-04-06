# #158 Iterating Lists with Indices

Revising methods for adding indexes to lists since PEP 3113 removed tuple parameter unpacking

## Notes

In Python 3.0, [PEP 3113](https://www.python.org/dev/peps/pep-3113/) removed tuple parameter unpacking.

This means that, for example, implicit unpacking of tuples for a lambda like this will no longer work and will generate a syntax error:

    lambda (x, y): x + y

Tuples now requires explicit unpacking, like this:

    lambda x_y: x_y[0] + x_y[1]

[Getting index of item while processing a list using map in python](https://stackoverflow.com/questions/5432762/getting-index-of-item-while-processing-a-list-using-map-in-python) is a classic example of how automatic unpacking was used in the past:

    Python 2.7.18 (default, Dec 26 2020, 15:56:25)
    >>> ranked_users = ['jon','bob','jane','alice','chris']
    >>> map(lambda (i, name): {'name': name, 'rank': i}, enumerate(ranked_users))
    [{'name': 'jon', 'rank': 0}, {'name': 'bob', 'rank': 1}, {'name': 'jane', 'rank': 2}, {'name': 'alice', 'rank': 3}, {'name': 'chris', 'rank': 4}]

However in Python 3:

    Python 3.7.3 (default, Dec 16 2020, 12:00:16)
    >>> ranked_users = ['jon','bob','jane','alice','chris']
    >>> map(lambda (i, name): {'name': name, 'rank': i}, enumerate(ranked_users))
      File "<stdin>", line 1
        map(lambda (i, name): {'name': name, 'rank': i}, enumerate(ranked_users))
                   ^
    SyntaxError: invalid syntax

There are a few ways to avoid this problem...

### Explicit Tuple Unpacking

The easiest way of changing existing code is probably to simply convert implicit unpacking to explicit unpacking:

    Python 3.7.3 (default, Dec 16 2020, 12:00:16)
    >>> ranked_users = ['jon','bob','jane','alice','chris']
    >>> map(lambda i_name: {'name': i_name[1], 'rank': i_name[0]}, enumerate(ranked_users))
    <map object at 0x1097b0860>
    >>> list(_)
    [{'name': 'jon', 'rank': 0}, {'name': 'bob', 'rank': 1}, {'name': 'jane', 'rank': 2}, {'name': 'alice', 'rank': 3}, {'name': 'chris', 'rank': 4}]

Note: in Python 3, the `map()` function now returns an iterator, hence use of `list()` to unroll the result. See
[Views And Iterators Instead Of Lists](https://docs.python.org/3.0/whatsnew/3.0.html#views-and-iterators-instead-of-lists)

### List Comprehension

Another approach is to simply enumerate with a list comprehension, for example:

    Python 3.7.3 (default, Dec 16 2020, 12:00:16)
    >>> ranked_users = ['jon','bob','jane','alice','chris']
    >>> [{'name': name, 'rank': i} for i, name in enumerate(ranked_users)]
    [{'name': 'jon', 'rank': 0}, {'name': 'bob', 'rank': 1}, {'name': 'jane', 'rank': 2}, {'name': 'alice', 'rank': 3}, {'name': 'chris', 'rank': 4}]

### Running The Examples

There are two example files:

* [py2_rank_players.py](./py2_rank_players.py) - demonstrates three possible approaches for Python 2
* [py3_rank_players.py](./py3_rank_players.py) - demonstrates two possible approaches for Python 3

Running with Python 2:

    $ pyenv shell 2.7.18
    $ ./py2_rank_players.py
    ...
    ----------------------------------------------------------------------
    Ran 3 tests in 0.000s

    OK
    $ ./py3_rank_players.py
    ..
    ----------------------------------------------------------------------
    Ran 2 tests in 0.000s

    OK

Running with Python 3:

    $ pyenv shell 3.7.3
    $ ./py2_rank_players.py
    File "./py2_rank_players.py", line 12
        return map(lambda (i, player_info): add_rank(i, player_info), enumerate(player_list))
                        ^
    SyntaxError: invalid syntax
    $ ./py3_rank_players.py
    ..
    ----------------------------------------------------------------------
    Ran 2 tests in 0.000s

    OK

## Credits and References

* [PEP 3113](https://www.python.org/dev/peps/pep-3113/) Removal of Tuple Parameter Unpacking
* [Views And Iterators Instead Of Lists](https://docs.python.org/3.0/whatsnew/3.0.html#views-and-iterators-instead-of-lists) - What’s New In Python 3.0
