# Installing Python 2 and 3 on MacOS

Notes on installing and maintaining python 2 and 3 versions on MacOS.

## Notes

### Homebrew

I'm using brew to install and upgrade system versions of python.

```
brew install python
brew install python3
```

Currently, the default python in my system is 2.7:

```
$ python --version
Python 2.7.16
$ which python
/usr/local/bin/python
$ which python3
/usr/local/bin/python3
```

### Using VirtualEnv

To install [virtualenv](https://virtualenv.readthedocs.org/en/latest/), it is now recommended to use pip user packages:

```
pip install --user virtualenv
```

NB: previously (and I think what I originally used on my machine) was to use easy_install `sudo easy_install virtualenv`.

Creating a python 3 virtual environment

```
$ virtualenv -p python3 venv3
$ source venv3/bin/activate
(venv3) $ python --version
Python 3.7.4
(venv3) $ deactivate
$
```

Creating a python 2 virtual environment

```
$ virtualenv venv
$ source venv/bin/activate
(venv) $ python --version
Python 2.7.16
(venv) $ deactivate
$
```

## Credits and References

* [python.org](https://www.python.org/)
* [virtualenv](https://virtualenv.readthedocs.org/en/latest/)
* [my comparison of Ruby and Python development support tools](https://blog.tardate.com/2012/10/the-full-monty-from-ruby-to-python.html)
* [Installing and using virtualenv with Python 3](https://help.dreamhost.com/hc/en-us/articles/115000695551-Installing-and-using-virtualenv-with-Python-3)
* [How to manage multiple Python versions and virtual environments ?](https://www.freecodecamp.org/news/manage-multiple-python-versions-and-virtual-environments-venv-pyenv-pyvenv-a29fb00c296f/)
