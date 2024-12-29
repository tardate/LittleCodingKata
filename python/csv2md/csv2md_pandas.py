#! /usr/bin/env python
import pandas as pd
import sys


def convert(infile, outfile):
    datafile = pd.read_csv(infile)
    markdown_table = datafile.to_markdown(index=False)
    with open(outfile, 'w') as f:
        f.write(markdown_table)


if __name__ == "__main__":
    if len(sys.argv) < 3:
        print("Usage: python csv2md_pandas.py <input.csv> <output.md>")
        sys.exit(1)
    convert(sys.argv[1], sys.argv[2])
