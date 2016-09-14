#! /usr/bin/env python
import argparse

def add(a, b):
    """ Short script to add two numbers """
    return a + b

if __name__ == '__main__':
    parser = argparse.ArgumentParser(description="Add two numbers")
    parser.add_argument(
        '-a',
        help='First value',
        type=float,
        default=0
    )
    parser.add_argument(
      '-b',
      help='Second value',
      type=float,
      default=0
    )
    args = parser.parse_args()
    print(add(args.a, args.b))
