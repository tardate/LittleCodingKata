# Patching Text Files

Simple tricks for updating text files with perl


[:arrow_forward: return to the Catalog](https://codingkata.tardate.com)

## Notes

Take theses three `perl` command options:

* `-i` enables editing files in place, with the option to back up the original file first.
* `-p` assume "while (<>) { print; }" loop around the program, so it works like sed
* `-e` executes the program given on the command line

Together these allow simple one-liners for modifying text files with arbitrary complexity:
from simple substitutions to conditional and sophisticated modifications.

The [examples.sh](./examples.sh) script has two examples to demonstrate the principle.

NB: on posix systems, use single quotes for `-e` programs to avoid shell command substitution.

### Example

```
$ ./examples.sh
Installing example.txt from template..

Original example.txt..
line=1
line=2
my_key=old.host.com
line=3
line=4

Example 1: General substitution (no file backup)
1,2c1,2
< row=1
< row=2
---
> line=1
> line=2
4,5c4,5
< row=3
< row=4
---
> line=3
> line=4

Example 2: Dependent substitution (with backup)
3c3
< my_key=new.service.io
---
> my_key=old.host.com

Final example.txt..
row=1
row=2
my_key=new.service.io
row=3
row=4

```

## Credits and References
* [The Perl Programming Language](https://www.perl.org/)
* [8 Awesome Perl Command Line Arguments You Should Know](http://www.thegeekstuff.com/2010/06/perl-command-line-options/)
* [Perl flags -pe, -pi, -p, -w, -d, -i, -t?](http://stackoverflow.com/questions/6302025/perl-flags-pe-pi-p-w-d-i-t) - SO
