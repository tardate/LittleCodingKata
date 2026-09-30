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
