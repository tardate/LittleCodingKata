#! /usr/bin/env python
from sys import argv
import os
import random


def pick(number_count, upper_limit):
    if number_count > upper_limit:
        raise Exception('Upper limit must be >= the number to pick')

    random.seed()

    choices = set()
    while len(choices) < number_count:
        choices.add(random.randint(1, upper_limit))

    return sorted(list(choices))


if __name__ == '__main__':
    if len(argv) == 3:
        numbers = pick(int(argv[1]), int(argv[2]))
        print(', '.join([str(i) for i in numbers]))
    else:
        script = argv[0]
        print(
            f"Usage: python {script} <number_to_pick> <max>",
            "e.g:",
            "",
            f"    python {script} 6 40",
            "    5, 6, 14, 28, 30, 38",
            sep=os.linesep
        )

