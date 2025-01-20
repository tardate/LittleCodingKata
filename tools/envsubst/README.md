# #001 envsubst

substitute shell variables in text

## Notes

`envsubst` is is available on most *nix systems and can be installed on MacOS as part of the BSD gettext library.

It's a useful tool for either completely or selectively substituting environment variables
in text that has shell format strings.

Example uses include:

* generating config files from templates with variable substitution

## Quick Example

`envsubst` will attempt to substitute all variable by default:

```sh
$ echo 'substituting ${TEST} ${ALT} ${NADA}' | TEST=abc ALT=alt envsubst
substituting abc alt
```

Or you can give it a constrained list of variables to interpolate:

```sh
$ echo 'substituting ${TEST} ${ALT} ${NADA}' | TEST=abc ALT=alt envsubst '$TEST:$ALT'
substituting abc alt ${NADA}
```

## MacOS Installation

Easy to install with homebrew:

```sh
brew install gettext
```

But note the formula is keg-only, which means it was not symlinked into /usr/local.
So while you could directly reference `/usr/local/opt/gettext/bin/envsubst` or add that to the path,
`brew link` can be used to add the symlinks:

```sh
$ brew link --force gettext
$ which envsubst
/usr/local/bin/envsubst
```

When done, you can unlink if desired:

```sh
brew unlink gettext
```

## Credits and References

* [envsubst: command not found on Mac OS X 10.8](http://stackoverflow.com/questions/23620827/envsubst-command-not-found-on-mac-os-x-10-8)
* [man envsubst](http://www.unix.com/man-page/linux/1/envsubst/)
* [gettext](http://brewformulas.org/gettext) - brew formula doc
* [gettext.rb](https://github.com/Homebrew/homebrew/blob/master/Library/Formula/gettext.rb) - brew formula source
