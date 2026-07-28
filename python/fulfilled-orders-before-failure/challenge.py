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
