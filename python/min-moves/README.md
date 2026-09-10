# #480 minMoves

Using python to unlock a backpack: cassidoo's interview question of the week (2026-09-06).

## Notes

The [interview question of the week (2026-09-06)](https://buttondown.com/cassidoo/archive/u1f6e3-ufe0f-habit-is-persistence-in-practice/):

> You have a backpack lock's starting position, and the code to unlock it, represented as two strings of integers. In one move, you may rotate any single digit one step up or down, with 0 and 9 considered adjacent. Return the minimum number of moves needed to transform the starting code into the unlock code.
>
> Example:
>
> ```ts
> minMoves("8051", "1199")
> > 10
>
> minMoves("000", "555")
> > 15
>
> minMoves("109", "990")
> > 4
> ```

### Thinking about the Problem

This seems pretty straight-forward.
For each digit, we find the delta between the positions by simple subtraction.
If the difference is more than 5, then we subtract from 10 i.e. rotate in reverse.

### Initial Solution

The python [`zip()`](https://www.w3schools.com/python/ref_func_zip.asp) function makes it easy to iterate each pair of digits in turn.
Then we can sum over a simple list comprehension:

```python
def minMoves(current, code):
    return sum(
      10 - abs(int(a) - int(b)) if abs(int(a) - int(b)) > 5 else abs(int(a) - int(b))
      for a, b in zip(current, code)
    )
```

I think I prefer this as more canonical python to the (perhaps clearer) procedural version:

```python
def minMoves(current, code):
    total = 0

    for a, b in zip(current, code):
        diff = abs(int(a) - int(b))
        distance = min(diff, 10 - diff)
        total += distance

    return total
```

And that works:

```sh
$ ./challenge.py 8051 1199
# Given:
# * Starting position: 8051
# * Lock Code: 1199
# Minimum moves required to unlock:
10
$ ./challenge.py 000 555
# Given:
# * Starting position: 000
# * Lock Code: 555
# Minimum moves required to unlock:
15
$ ./challenge.py 109 990
# Given:
# * Starting position: 109
# * Lock Code: 990
# Minimum moves required to unlock:
4
```

## Improving the Code?

While it's a clever one-liner, the duplicated difference calculation makes me itch.

We can nest the list comprehension to create a temporary variable `diff`:

```python
def minMoves(current, code):
    return sum(
        (10 - diff if diff > 5 else diff)
        for a, b in zip(current, code)
        for diff in [abs(int(a) - int(b))]
    )
```

Yes, still works. Is it an improvement? Hmm, debatable!

Rather than do the explicit conditional `(10 - diff if diff > 5 else diff)`, we could alternatively just calculate the `min()`:

```python
def minMoves(current, code):
    return sum(
        min(diff, 10 - diff)
        for a, b in zip(current, code)
        for diff in [abs(int(a) - int(b))]
    )
```

### Tests

I've setup some validation in [test_challenge.py](./test_challenge.py):

```sh
$ ./test_challenge.py
...
----------------------------------------------------------------------
Ran 3 tests in 0.000s

OK
```

### Final Code

Final code is in [challenge.py](./challenge.py):

```python
#! /usr/bin/env python
from sys import argv
from sys import stderr


def minMoves(current, code):
    return sum(
        min(diff, 10 - diff)
        for a, b in zip(current, code)
        for diff in [abs(int(a) - int(b))]
    )


if __name__ == '__main__':
    if len(argv) == 3:
        current = argv[1]
        code = argv[2]
        print("# Given:", file=stderr)
        print("# * Starting position:", current, file=stderr)
        print("# * Lock Code:", code, file=stderr)
        print("# Minimum moves required to unlock:", file=stderr)
        print(minMoves(current, code))
    else:
        print("Usage: challenge.py '<current-position>' '<code>'", file=stderr)
```

## Credits and References

* [cassidoo's interview question of the week (2026-09-06)](https://buttondown.com/cassidoo/archive/u1f6e3-ufe0f-habit-is-persistence-in-practice/)
* [python `zip()` function](https://www.w3schools.com/python/ref_func_zip.asp)
