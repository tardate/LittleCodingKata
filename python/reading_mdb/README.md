# Reading MDB Files

Reading Microsoft Access database files on a Mac with Python

[:arrow_forward: return to the Catalog](https://codingkata.tardate.com)

## Notes

I have some old Microsoft Access databases lying around ... I wonder if there's anything useful in them?
And can I read them from my Mac without installing a whole suite of Microsoft tools?

There's at least one way to do this that I've found to work:
[mdbtools](https://github.com/brianb/mdbtools) for *nix MDB support and
[pandas_access](https://pypi.org/project/pandas_access/) for a tidy python wrapper.

I ran these tests with python 3..

### Installing

```
$ brew install mdbtools
...
Installing dependencies for mdbtools: gettext, sqlite, python and glib
...
$ pip3 install -r requirements.txt

``

### Some `pandas_access` Basics

Loading a table as a [pandas.DataFrame](https://pandas.pydata.org/pandas-docs/stable/reference/api/pandas.DataFrame.html)

```
import pandas_access as mdb

df = mdb.read_table('quotes.mdb', 'Quotations')
```

Getting column names.
`df.columns` returns a
[pandas.Index](https://pandas.pydata.org/pandas-docs/stable/reference/api/pandas.Index.html).
and `df.columns` returns a
[numpy.ndarray](https://docs.scipy.org/doc/numpy/reference/generated/numpy.ndarray.html)

```
print('Columns: {}'.format(list(df.columns.values)))
=> Columns: ['AuthorLast', 'AuthorFirst', 'Quote', 'QuoteDate', 'Circumstance']
```

### Some Examples

Listing tables in a database...

```
$ ./show_tables.py quotes.mdb
Listing the tables in quotes.mdb..
Quotations
```

Listing records in a table...

```
$ ./show_records.py quotes.mdb Quotations
Listing the records in quotes.mdb::Quotations..
Table has 2945 rows
Columns: ['AuthorLast', 'AuthorFirst', 'Quote', 'QuoteDate', 'Circumstance']
--------------
AuthorLast: Edison
AuthorFirst: Thomas
Quote: ...I have not failed. I've just found 10,000 ways that won't work.
QuoteDate: nan
Circumstance: nan
--------------
AuthorLast: Asimov
AuthorFirst: Isaac
Quote: [John] Dalton's records, carefully preserved for a century, were destroyed during the World War II bombing of Manchester. It is not only the living who are killed in war.
QuoteDate: nan
Circumstance: nan
--------------
AuthorLast: Gates
AuthorFirst: Bill
Quote: 640K ought to be enough for anybody.
QuoteDate: nan
Circumstance: In 1981
--------------
AuthorLast: Berra
AuthorFirst: Yogi
Quote: 95% of this game is half mental.
QuoteDate: nan
Circumstance: nan
--------------
AuthorLast: Dirksen
AuthorFirst: Everett
Quote: A billion here, a billion there, and pretty soon you're talking about real money.
QuoteDate: nan
Circumstance: nan
--------------
AuthorLast: Marx
AuthorFirst: Groucho
Quote: A child of five would understand this. Send someone to fetch a child of five.
QuoteDate: nan
Circumstance: nan
...(etc)...
```

## Credits and References

* [Reading MS Access MDB Files on Mac](https://medium.com/@wenyu.z/reading-ms-access-mdb-files-on-mac-969a176baa7a)
* [how to deal with .mdb access files with python](https://stackoverflow.com/a/42610107/6329)
* [mdbtools](https://github.com/brianb/mdbtools)
* [pandas_access](https://pypi.org/project/pandas_access/)
