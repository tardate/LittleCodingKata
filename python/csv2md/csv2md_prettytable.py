#! /usr/bin/env python
from prettytable import PrettyTable
from prettytable import TableStyle

import csv
import sys


def convert(infile):
    with open(infile) as csv_file:
        csv_reader = csv.reader(csv_file)
        headers = next(csv_reader)
        table = PrettyTable(headers)
        table.set_style(TableStyle.MARKDOWN)
        for row in csv_reader:
            table.add_row(row)
    print(table.get_string(format=True))


if __name__ == "__main__":
    if len(sys.argv) < 2:
        print("Usage: python csv2md_prettytable.py <input.csv>")
        sys.exit(1)
    convert(sys.argv[1])
