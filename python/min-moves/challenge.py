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
