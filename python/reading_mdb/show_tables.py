#! /usr/bin/env python
from sys import argv
import pandas_access as mdb


def show_tables(path='<file_name>.mdb'):
    print('Listing the tables in {}..'.format(path))
    for table in mdb.list_tables(path):
      print(table)


if __name__ == '__main__':
    show_tables(argv[1] if len(argv) > 1 else 'quotes.mdb')
