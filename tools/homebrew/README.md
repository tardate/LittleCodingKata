# #203 Tips and Tricks

I often use [Homebrew](https://brew.sh/) to manage software installations on my Mac.

This is a collection of tips and tricks... basically things I use occasionally but always forget in the meantime.

## Checking if a Package is Installed

Trick: use `brew ls --versions` to attempt to report on installed packages

I have mongodb installed:

```bash
$ brew ls --versions mongodb | grep -q mongodb
$ echo $?
0
```

But I don't have talloc installed:

```bash
$ brew ls --versions talloc | grep -q talloc
$ echo $?
1
````

Combining a check for brew along with a check for a package

```bash
if [ $(which brew) ]
then
  brew_talloc_version=$(brew ls --versions talloc)
else
  brew_talloc_version="brew not installed"
fi
if echo "${brew_talloc_version}" | grep -q "talloc"
then
  echo "brew has talloc installed: ${brew_talloc_version}"
else
  brew install talloc
fi
```

## Credits and References

* [Homebrew](https://brew.sh/)
* [homebrew](https://github.com/Homebrew/brew)
* [SO: Detect if homebrew package is installed](http://stackoverflow.com/questions/20802320/detect-if-homebrew-package-is-installed)
