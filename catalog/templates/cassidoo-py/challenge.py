#! /usr/bin/env python
from sys import argv
from sys import stderr
import json


def challenge(param1):
    pass


if __name__ == '__main__':
    if len(argv) == 2:
        param1 = json.loads(argv[1])
        print("# Given:", file=stderr)
        print("# * param1:", param1, file=stderr)
        print("# Result:", file=stderr)
        print(challenge(param1))
    else:
        print("Usage: challenge.py '<param1>'", file=stderr)
