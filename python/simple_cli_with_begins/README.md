# Simple Command Line Tools with begins

Using the begins library to write command line scripts without all the cruft.


## Notes

The begins library replaces conventional argparse/main function pattern with a simple decorator.
I found this in [20 Python Libraries You Aren't Using (But Should)](https://www.goodreads.com/book/show/32051366-20-python-libraries-you-aren-t-using-but-should), from which I've basically snaffled this example.

The following are functionally equivalent. First the traditional way:

```
import argparse

def add(a, b):
    return a + b

if __name__ == '__main__':
    parser = argparse.ArgumentParser(description="Add two numbers")
    parser.add_argument('-a', help='First value', type=float, default=0)
    parser.add_argument('-b', help='Second value', type=float, default=0)
    args = parser.parse_args()
    print(add(args.a, args.b))
```

And now using begins (python3 syntax):

```
import begin

@begin.start(auto_convert=True)
def add(a: 'First value' = 0.0, b: 'Second value' = 0.0):
    """ Add two numbers """
    print(a + b)
```


## Setup

Use the requirements.txt to install begins:

```
$ pip install -r requirements.txt
```

The examples that follow use both python 2 and python 3. the begins library needs to installed for both.

## Running the Examples

`add.py` is the conventional approach, with argparse and an explicit main section:

```
$ python add.py -h
usage: add.py [-h] [-a A] [-b B]

Add two numbers

optional arguments:
  -h, --help  show this help message and exit
  -a A        First value
  -b B        Second value

$ python add.py -a 3 -b 4
7.0
```

`add_with_begins.py` uses begins and python 2 compatible syntax:

```
$ python add_with_begins.py -h
usage: add_with_begins.py [-h] [--a A] [--b B]

Add two numbers

optional arguments:
  -h, --help   show this help message and exit
  --a A, -a A  (default: 0.0)
  --b B, -b B  (default: 0.0)

$ python add_with_begins.py -a 3 -b 4
7.0
```

`add_with_begins3.py` uses begins and python 3 compatible syntax:

```
$ python3 add_with_begins3.py -h
usage: add_with_begins3.py [-h] [--a A] [--b B]

Add two numbers

optional arguments:
  -h, --help   show this help message and exit
  --a A, -a A  First value (default: 0.0)
  --b B, -b B  Second value (default: 0.0)

$ python3 add_with_begins3.py -a 3 -b 4
7.0
```

## Credits and References
* [begins](https://pypi.python.org/pypi/begins) - pypi
* [begins](https://github.com/aliles/begins) - GitHub
* [20 Python Libraries You Aren't Using (But Should)](https://www.goodreads.com/book/show/32051366-20-python-libraries-you-aren-t-using-but-should)
