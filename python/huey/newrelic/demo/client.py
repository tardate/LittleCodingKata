#! /usr/bin/env python
import random
import time
from tasks import add_numbers


if __name__ == '__main__':
    while True:
        a = random.randint(0, 1000)
        b = random.randint(0, 1000)
        c = add_numbers(a, b).get(True)
        print(f'{a} + {b} = {c}')
        time.sleep(1)
