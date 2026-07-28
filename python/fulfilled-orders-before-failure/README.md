# #xxx fulfilledOrdersBeforeFailure

Using python to run an ice cream stand: cassidoo's interview question of the week (2026-07-27).

## Notes

The [interview question of the week (2026-07-27)](https://buttondown.com/cassidoo/archive/u1f635-u1f4ab-time-you-enjoy-wasting-is-not/):

> Given an array of ice cream orders and a freezer stock map, return how many orders can be fulfilled before the first unavailable flavor.
>
> Example:
>
> ```ts
> > fulfilledOrdersBeforeFailure(
>     [["chocolate"],["chocolate"],["chocolate"]],
>     { chocolate: 2 })
> > 2
>
> > fulfilledOrdersBeforeFailure(
>     [["vanilla","vanilla"],["chocolate","mint"],["strawberry"],["strawberry","mint"]],
>     { vanilla: 2, chocolate: 1, mint: 1, strawberry: 5 })
> > 3
>
> > fulfilledOrdersBeforeFailure(
>     [["rocky road"],["vanilla"]],
>     { vanilla: 3 })
> > 0
> ```

### Thinking about the Problem

The question appears to be quite straight-forward. We have orders and an inventory of ice cream.

There is some specific phrasing to note: "..how many orders can be fulfilled **before** the first unavailable flavor."

This implies sequential order processing, and we stop when we hit the first unavailable flavor.
In other words, even if there are later orders that could be fulfilled with available stock, we don't count those.
This interpretation is confirmed by the third example.

### A Solution

Since the sequence of processing matters, the approach can't really avoid simply iterating until we fail.

Here's a first shot. It seems fairly naïve, but it is not obvious how this could be improved much:

```python
def fulfilledOrdersBeforeFailure(orders, inventory):
    fulfilled = 0
    for order in orders:
        can_fulfill = True
        for item in order:
            if inventory.get(item, 0) > 0:
                inventory[item] -= 1
            else:
                can_fulfill = False
                break
        if can_fulfill:
            fulfilled += 1
        else:
            break
    return fulfilled
```

Does it work? Yes, it does the job:

```sh
$ ./challenge.py
Usage: challenge.py '[[<order_items>],...]' '{<flavour>: <quantity>, ...}'
$ ./challenge.py '[["chocolate"],["chocolate"],["chocolate"]]' '{ "chocolate": 2 }'
# Given:
# * Orders: [['chocolate'], ['chocolate'], ['chocolate']]
# * Inventory: {'chocolate': 2}
# Orders that can be fulfilled before failure:
2
$ ./challenge.py '[["vanilla","vanilla"],["chocolate","mint"],["strawberry"],["strawberry","mint"]]' '{ "vanilla": 2, "chocolate": 1, "mint": 1, "strawberry": 5 }'
# Given:
# * Orders: [['vanilla', 'vanilla'], ['chocolate', 'mint'], ['strawberry'], ['strawberry', 'mint']]
# * Inventory: {'vanilla': 2, 'chocolate': 1, 'mint': 1, 'strawberry': 5}
# Orders that can be fulfilled before failure:
3
$ ./challenge.py '[["rocky road"],["vanilla"]]' '{ "vanilla": 3 }'
# Given:
# * Orders: [['rocky road'], ['vanilla']]
# * Inventory: {'vanilla': 3}
# Orders that can be fulfilled before failure:
0
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


def fulfilledOrdersBeforeFailure(orders, inventory):
    fulfilled = 0
    for order in orders:
        can_fulfill = True
        for item in order:
            if inventory.get(item, 0) > 0:
                inventory[item] -= 1
            else:
                can_fulfill = False
                break
        if can_fulfill:
            fulfilled += 1
        else:
            break
    return fulfilled


if __name__ == '__main__':
    if len(argv) == 3:
        orders = json.loads(argv[1])
        inventory = json.loads(argv[2])
        print("# Given:", file=stderr)
        print("# * Orders:", orders, file=stderr)
        print("# * Inventory:", inventory, file=stderr)
        print("# Orders that can be fulfilled before failure:", file=stderr)
        print(fulfilledOrdersBeforeFailure(orders, inventory))
    else:
        print("Usage: challenge.py '[[<order_items>],...]' '{<flavour>: <quantity>, ...}'", file=stderr)
```

## Credits and References

* [cassidoo's interview question of the week (2026-07-27)](https://buttondown.com/cassidoo/archive/u1f635-u1f4ab-time-you-enjoy-wasting-is-not/)
