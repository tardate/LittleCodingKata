# #209 Python 2 and 3 on MacOS

Notes on installing and maintaining python 2 and 3 versions on MacOS.

## Notes

### macOS Sonoma

There is no python pre-installed with Sonoma 14.x.
I'm no longer installing a python 2 version ... so far no need; fingers crossed!

#### HomeBrew

Installing python with HomeBrew:

    $ brew install python
    $ brew info python
    ==> python@3.11: stable 3.11.6 (bottled)
    Interpreted, interactive, object-oriented programming language
    https://www.python.org/
    /opt/homebrew/Cellar/python@3.11/3.11.6_1 (3,300 files, 62.2MB) *
      Poured from bottle using the formulae.brew.sh API on 2023-12-29 at 14:00:53
    From: https://github.com/Homebrew/homebrew-core/blob/HEAD/Formula/p/python@3.11.rb
    License: Python-2.0
    ==> Dependencies
    Build: pkg-config ✘
    Required: mpdecimal ✔, openssl@3 ✔, sqlite ✔, xz ✔
    ==> Caveats
    Python has been installed as
      /opt/homebrew/bin/python3

    Unversioned symlinks `python`, `python-config`, `pip` etc. pointing to
    `python3`, `python3-config`, `pip3` etc., respectively, have been installed into
      /opt/homebrew/opt/python@3.11/libexec/bin

    You can install Python packages with
      pip3 install <package>
    They will install into the site-package directory
      /opt/homebrew/lib/python3.11/site-packages

    tkinter is no longer included with this formula, but it is available separately:
      brew install python-tk@3.11

    gdbm (`dbm.gnu`) is no longer included in this formula, but it is available separately:
      brew install python-gdbm@3.11
    `dbm.ndbm` changed database backends in Homebrew Python 3.11.
    If you need to read a database from a previous Homebrew Python created via `dbm.ndbm`,
    you'll need to read your database using the older version of Homebrew Python and convert to another format.
    `dbm` still defaults to `dbm.gnu` when it is installed.

    For more information about Homebrew and Python, see: https://docs.brew.sh/Homebrew-and-Python
    ==> Analytics
    install: 182,589 (30 days), 728,874 (90 days), 2,297,989 (365 days)
    install-on-request: 121,915 (30 days), 443,490 (90 days), 1,229,628 (365 days)
    build-error: 180 (30 days)

I've added unversioned python symlinks to the path:

    export PATH="$PATH:/opt/homebrew/opt/python@3.11/libexec/bin"

Currently:

    $ python --version
    Python 3.11.6

#### Virtual Environments

With python 3, so much easier to create a virtual environment:

    $ python -m venv venv
    $ source venv/bin/activate
    (venv) $

### Earlier MacOS Versions

I didn't make a note of which macOS version these earlier notes were made with. High Sierra?
Definitely still on Intel processor.

#### HomeBrew

I'm using brew to install and upgrade system versions of python.

    brew install python
    brew install python3

Currently, the default python in my system is 2.7:

    $ python --version
    Python 2.7.16
    $ which python
    /usr/local/bin/python
    $ which python3
    /usr/local/bin/python3

#### Using VirtualEnv

To install [virtualenv](https://virtualenv.readthedocs.org/en/latest/), it is now recommended to use pip user packages:

    pip install --user virtualenv

NB: previously (and I think what I originally used on my machine) was to use easy_install `sudo easy_install virtualenv`.

Creating a python 3 virtual environment

    $ virtualenv -p python3 venv3
    $ source venv3/bin/activate
    (venv3) $ python --version
    Python 3.7.4
    (venv3) $ deactivate

Creating a python 2 virtual environment

    $ virtualenv venv
    $ source venv/bin/activate
    (venv) $ python --version
    Python 2.7.16
    (venv) $ deactivate

## Credits and References

* [python.org](https://www.python.org/)
* [virtualenv](https://virtualenv.readthedocs.org/en/latest/)
* [my comparison of Ruby and Python development support tools](https://blog.tardate.com/2012/10/the-full-monty-from-ruby-to-python.html)
* [Installing and using virtualenv with Python 3](https://help.dreamhost.com/hc/en-us/articles/115000695551-Installing-and-using-virtualenv-with-Python-3)
* [How to manage multiple Python versions and virtual environments ?](https://www.freecodecamp.org/news/manage-multiple-python-versions-and-virtual-environments-venv-pyenv-pyvenv-a29fb00c296f/)
