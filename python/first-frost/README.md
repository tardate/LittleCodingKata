# #489 firstFrost

Using python to find the first frost: cassidoo's interview question of the week (2026-09-28).

## Notes

The [interview question of the week (2026-09-28)](https://buttondown.com/cassidoo/archive/u1f3b9-to-take-a-fine-idea-and-make-something/):

> Given an array of daily temperatures and a number drop, return an array where each element is how many days you'd wait until it's at least drop degrees colder than that day. If that never happens, put 0.
>
> Example:
>
> ```ts
> > firstFrost([70, 68, 72, 60, 65, 55], 5)
> > [3, 2, 1, 2, 1, 0]
>
> > firstFrost([50, 49, 48], 5)
> > [0, 0, 0]
>
> > firstFrost([40, 30, 45, 20], 10)
> > [1, 2, 1, 0]
> ```

### Thinking about the Problem

For a given day, things are quite simple - scan ahead until the difference exceeds the drop.

The challenge is perhaps finding a smart way to do this without having to enumerate the array for each day separately.
Can't immediately think how, so it is perhaps best to just start with a naïve implementation and see if that prompts any ideas.

### Initial Solution

Starting with a naïve solution:

* scan the daily temperatures
* for each entry, scan ahead counting the days until the temperature drop exceeds the limit
* record the result and move on to the next day

```python
def firstFrost(daily_temps, drop):
    result = []
    for i, temp in enumerate(daily_temps):
        days_to_frost = 0
        for j in range(i + 1, len(daily_temps)):
            if daily_temps[j] <= temp - drop:
                days_to_frost = j - i
                break
        result.append(days_to_frost)
    return result
```

And that seems to work ok:

```sh
$ ./challenge.py "[70, 68, 72, 60, 65, 55]" 5
# Given:
# * Daily temperatures: [70, 68, 72, 60, 65, 55]
# * Drop: 5
# Days to wait for frost:
[3, 2, 1, 2, 1, 0]
$ ./challenge.py "[50, 49, 48]" 5 2> /dev/null
[0, 0, 0]
$ ./challenge.py "[40, 30, 45, 20]" 10 2> /dev/null
[1, 2, 1, 0]
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
import json


def firstFrost(daily_temps, drop):
    result = []
    for i, temp in enumerate(daily_temps):
        days_to_frost = 0
        for j in range(i + 1, len(daily_temps)):
            if daily_temps[j] <= temp - drop:
                days_to_frost = j - i
                break
        result.append(days_to_frost)
    return result


if __name__ == '__main__':
    if len(argv) == 3:
        daily_temps = json.loads(argv[1])
        drop = int(argv[2])
        print("# Given:", file=stderr)
        print("# * Daily temperatures:", daily_temps, file=stderr)
        print("# * Drop:", drop, file=stderr)
        print("# Days to wait for frost:", file=stderr)
        print(firstFrost(daily_temps, drop))
    else:
        print("Usage: challenge.py '<array of daily temperatures>' '<drop>'", file=stderr)
```

## Credits and References

* [cassidoo's interview question of the week (2026-09-28)](https://buttondown.com/cassidoo/archive/u1f3b9-to-take-a-fine-idea-and-make-something/)
