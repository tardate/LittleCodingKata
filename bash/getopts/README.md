# #252 getopts

Using the getopts utility for parsing options in shell scripts.

## Notes

[getopts](https://man7.org/linux/man-pages/man1/getopts.1p.html) is a POSIX system utility
available on most Unix/Linux style distributions.

It helps scripts retrieve options and option-arguments from a list of parameters.

```bash
$ ./example.sh -v -p 35
got p: 35
got v: true
```

### Parsing Options

```bash
while getopts "p:v" opt
do
  case $opt in
  p)
    # handling option with parameter -p XX
    p=$OPTARG
    ;;
  v)
    # handling option flag -v
    v=true
    ;;
  \?)
    # handling invalid options
    ;;
  esac
done
```

### Handling Boolean Option Flags

Accepting boolean option flags like `-v` with `while getopts "v" ...`:

```bash
$ ./example.sh
got p:
got v:
$ ./example.sh -v
got p:
got v: true
```

### Handling Options With Parameters

Accepting boolean option flags like `-p XX` with `while getopts "p:" ...`:

```bash
$ ./example.sh
got p:
got v:
$ ./example.sh -p 42
got p: 42
got v:
```

### Invalid Parameters

`getopts` will raise an error if parameters that don't match the options spec are provided e.g.

```bash
$ ./example.sh -x
./example.sh: illegal option -- x
(handling an error)

Usage

  ./example.sh -p value # set "p" to value
  ./example.sh -v       # set "v" true
  ./example.sh -h       # this message

```

### Accepting additional parameters

Note: `getopts` does *not* remove options from the shell arguments

If unknown argments comes before options, the options parsing fails silently (effectively skipped):

```bash
$ ./example.sh bogative -v -p 42
got p:
got v:
```

If arguments other than those parsed by `getopts` are required, they should come first and be removed from the args (using shift) before `getopts` parsing.

```bash
$ ./example.sh magic -v -p 42
magic: detected special argument
got p: 42
got v: true
```

## Credits and References

* [getopts(1p) — Linux manual page](https://man7.org/linux/man-pages/man1/getopts.1p.html)
* [Adding arguments and options to your Bash scripts](https://www.redhat.com/sysadmin/arguments-options-bash-scripts)
* [Bash Getopts](https://linuxhint.com/bash_getopts_example/)
* [The shift built-in](https://tldp.org/LDP/Bash-Beginners-Guide/html/sect_09_07.html)
