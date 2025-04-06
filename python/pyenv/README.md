# #155 pyenv

Using pyenv for managing multiple python environments.

## Notes

### Installation with brew

```sh
$ brew install pyenv
...

$ which pyenv
/usr/local/bin/pyenv

$ pyenv --help
Usage: pyenv <command> [<args>]

Some useful pyenv commands are:
   --version   Display the version of pyenv
   commands    List all available pyenv commands
   exec        Run an executable with the selected Python version
   global      Set or show the global Python version(s)
   help        Display help for a command
   hooks       List hook scripts for a given pyenv command
   init        Configure the shell environment for pyenv
   install     Install a Python version using python-build
   local       Set or show the local application-specific Python version(s)
   prefix      Display prefix for a Python version
sed: RE error: illegal byte sequence
   rehash      Rehash pyenv shims (run this after installing executables)
   root        Display the root directory where versions and shims are kept
   shell       Set or show the shell-specific Python version
   shims       List existing pyenv shims
   uninstall   Uninstall a specific Python version
   version     Show the current Python version(s) and its origin
   version-file   Detect the file that sets the current pyenv version
   version-name   Show the current Python version
   version-origin   Explain how the current Python version is set
   versions    List all Python versions available to pyenv
   whence      List all Python versions that contain the given executable
   which       Display the full path to an executable

See `pyenv help <command>' for information on a specific command.
For full documentation, see: https://github.com/pyenv/pyenv#readme
```

### Installing some Pythons

```sh
$ pyenv install 3.7.3
python-build: use openssl@1.1 from homebrew
python-build: use readline from homebrew
Downloading Python-3.7.3.tar.xz...
...
Installing Python-3.7.3...
...

$ pyenv install 2.7.18
python-build: use openssl from homebrew
python-build: use readline from homebrew
Downloading Python-2.7.18.tar.xz...
...
Installing Python-2.7.18...
```

### Using pyenv

```sh
$ pyenv global 3.7.3
$ pyenv versions
  system
  2.7.18
* 3.7.3 (set by /Users/paulgallagher/.pyenv/version)
```

Adding pyenv initialization to my `.bash_profile` ...

```sh
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi
```

```sh
$ pyenv version
3.7.3 (set by /Users/paulgallagher/.pyenv/version)
$ which python
/Users/paulgallagher/.pyenv/shims/python
$ python --version
Python 3.7.3

$ pyenv shell 2.7.18
$ pyenv version
2.7.18 (set by PYENV_VERSION environment variable)
$ python --version
Python 2.7.18

```

## Credits and References

* [pyenv](https://github.com/pyenv/pyenv)
* [The right and wrong way to set Python 3 as default on a Mac](https://opensource.com/article/19/5/python-3-default-mac)
