# #035 Case Statements

How to use case statements in the bash shell.


## Notes

The case statement (aka switch statements) is better suited to handling complex conditionals than nexted if conditions.
They also support regular-expression style pattern matching

Formally, the case statement is as follows (although normally written with line breaks between cases and commands):
```
case EXPRESSION in CASE1) COMMAND-LIST;; CASE2) COMMAND-LIST;; ... CASEN) COMMAND-LIST;; esac
```

Points to note:

* starts/ends with `case`/`esac`
* `;;` is required between cases. Unlike other languages, it cannot be omitted to allow control flow from one case to another
* it branches to the first matching case. Later matches (if any) are ignored.
* `*)` case is often used as a catch-all default - equivalent of an `else` condition.

## Example

See [case_examples.sh](./case_examples.sh) for various pattern matching options.

```
$ ./case_examples.sh 123
123 is: under 7*
$ ./case_examples.sh 888
888 is: like 7* or 8*
$ ./case_examples.sh 9
9 is: like 9*
$ ./case_examples.sh a
a is: a or b
$ ./case_examples.sh abc
abc is: abc
$ ./case_examples.sh def
def is: def
$ ./case_examples.sh left-hand
left-hand is: like *hand
$ ./case_examples.sh
help is: (default)
```

The [handle_emtpy_case.sh](./handle_emtpy_case.sh) example demonstrates matching blank

```
$ ./handle_emtpy_case.sh abc
abc is: defined option: abc
$ ./handle_emtpy_case.sh ""
 is: blank option
$ ./handle_emtpy_case.sh xyz
xyz is: (default)
```

## Credits and References
* [Switch case with fallthrough?](http://stackoverflow.com/questions/5562253/switch-case-with-fallthrough)
* [7.3. Using case statements](http://tldp.org/LDP/Bash-Beginners-Guide/html/sect_07_03.html) - Bash Guide for Beginners
* [5 Bash Case Statement Examples](http://www.thegeekstuff.com/2010/07/bash-case-statement/)
