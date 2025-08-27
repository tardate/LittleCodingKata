# #223 Ruby One-liners

All about one-liners with ruby.

## Notes

The [Ruby one-liners cookbook](https://learnbyexample.github.io/learn_ruby_oneliners/one-liner-introduction.html) has it all!

### Command Line Options

Using a ruby one-liner to format the ruby command line options as markdown for the table below...

```sh
ruby -h | ruby -F'  ' -ane 'puts $F[0].include?("Usage") ? "| Option | Description |\n|---|---|\n" : "| `#{$F[1]}` | #{$_.chomp.gsub($F[1],"").strip} |"'
```

| Option | Description |
|---|---|
| `-0[octal]` | specify record separator (\0, if no argument) |
| `-a` | autosplit mode with -n or -p (splits $_ into $F) |
| `-c` | check syntax only |
| `-Cdirectory` | cd to directory before executing your script |
| `-d` | set debugging flags (set $DEBUG to true) |
| `-e 'command'` | one line of script. Several -e's allowed. Omit [programfile] |
| `-Eex[:in]` | specify the default external and internal character encodings |
| `-Fpattern` | split() pattern for autosplit (-a) |
| `-i[extension]` | edit ARGV files in place (make backup if extension supplied) |
| `-Idirectory` | specify $LOAD_PATH directory (may be used more than once) |
| `-l` | enable line ending processing |
| `-n` | assume 'while gets(); ... end' loop around your script |
| `-p` | assume loop like -n but print line also like sed |
| `-rlibrary` | require the library before executing your script |
| `-s` | enable some switch parsing for switches after script name |
| `-S` | look for the script using PATH environment variable |
| `-v` | print the version number, then turn on verbose mode |
| `-w` | turn warnings on for your script |
| `-W[level=2\|:category]` | set warning level; 0=silence, 1=medium, 2=verbose |
| `-x[directory]` | strip off text before #!ruby line and perhaps cd to directory |
| `--jit` | enable JIT with default options (experimental) |
| `--jit-[option]` | enable JIT with an option (experimental) |
| `-h` | show this message, -elp for more info |

### Examples

See the
[Ruby one-liners GitHub source](https://github.com/learnbyexample/learn_ruby_oneliners)
for a full suite of examples.

```bash
$ ./examples.sh
Regexp based filtering - should match /foo/a/
/foo/a/report.log
```

## Credits and References

* [Ruby one-liners cookbook](https://learnbyexample.github.io/learn_ruby_oneliners/one-liner-introduction.html)
* [Ruby one-liners cookbook](https://github.com/learnbyexample/learn_ruby_oneliners) - GitHub sources
