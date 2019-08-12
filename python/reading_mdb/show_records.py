#! /usr/bin/env python
from sys import argv
import pandas_access as mdb


def show_records(path, table):
    print('Listing the records in {}::{}..'.format(path, table))
    df = mdb.read_table(path, table)
    print('Table has {} rows'.format(df.size))
    print('Columns: {}'.format(list(df.columns.values)))
    # print(df.columns)
    # print(df.size)
    # print(df.values)
    for index, row in df.iterrows():
        print('--------------')
        for column in df.columns.values:
            print('{}: {}'.format(column, row[column]))


if __name__ == '__main__':
    show_records(
      argv[1] if len(argv) > 1 else 'quotes.mdb',
      argv[2] if len(argv) > 2 else 'Quotations'
    )
