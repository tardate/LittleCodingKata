# Bash if and test

All about if/then test constructs in Bash scripting

## Notes

The if/then construct tests whether the exit status of a list of commands is 0, and if so, executes one or more commands.

Bash has a `[` [left bracket special character command](https://tldp.org/LDP/abs/html/special-chars.html#LEFTBRACKET).
It is a synonym for test, and a builtin for efficiency reasons.
This command considers its arguments as comparison expressions or file tests and returns an exit status corresponding to the result of the comparison (0 for true, 1 for false).

With version 2.02, Bash introduced the `[[ ... ]]` [extended test command](https://tldp.org/LDP/abs/html/testconstructs.html#DBLBRACKETS).
Note that [[ is a keyword, not a command.

### string variable tests

The main string [comparison operators](https://tldp.org/LDP/abs/html/comparison-ops.html):

* ` = ` : equal e.g. `if [ "$a" = "$b" ]`
* ` == ` : equal e.g. `if [ "$a" == "$b" ]`. Same as `=` but with different behaviour within double-brackets:
  * `[[ $a == z* ]]`   # True if $a starts with an "z" (pattern matching).
  * `[[ $a == "z*" ]]` # True if $a is equal to z* (literal matching).
  * `[ $a == z* ]`     # File globbing and word splitting take place.
  * `[ "$a" == "z*" ]` # True if $a is equal to z* (literal matching).
* ` != ` : not equal e.g. `if [ "$a" != "$b" ]`
* ` < ` : less than, aSCII sort order e.g. `if [ "$a" \< "$b" ]` or `if [[ "$a" < "$b" ]]`
* ` > ` : greater than, ASCII sort order e.g. `if [ "$a" \> "$b" ]` or `if [[ "$a" > "$b" ]]`
* ` -z ` : string is null, that is, has zero length e.g. `if [ -z "$a" ]`
* ` -n ` : string is not null e.g. `if [ -n "$a" ]`

For null string tests, **always** quote the variable. If not quoted, will usually work but is unsafe depending on how the string expands.

The [`=~` operator](https://www.gnu.org/savannah-checkouts/gnu/bash/manual/bash.html#Conditional-Constructs)
performs [regular expression pattern matching](https://tldp.org/LDP/abs/html/x17129.html).

Running the example [test_string_variables.sh](./test_string_variables.sh) script:

```
$ ./test_string_variables.sh

# = operator tests (equal):
Given: VAR_SET=canary and VAR_NOT_SET not defined
it passes using [ "${VAR_SET}" = "canary" ] # VAR_SET: canary
it passes using [[ "${VAR_SET}" = "canary" ]] # VAR_SET: canary
correctly fails using [ "${VAR_NOT_SET=}" = "canary" ] # VAR_NOT_SET:
correctly fails using [[ "${VAR_NOT_SET=}" = "canary" ]] # VAR_NOT_SET:

## == operator tests (equal):
Given: VAR_SET=canary and VAR_NOT_SET not defined
it passes using [ "${VAR_SET}" == "canary" ] # VAR_SET: canary
it passes using [[ "${VAR_SET}" == "canary" ]] # VAR_SET: canary
correctly fails using [ "${VAR_NOT_SET}" == "canary" ] # VAR_NOT_SET:
correctly fails using [[ "${VAR_NOT_SET}" == "canary" ]] # VAR_NOT_SET:

## == operator tests (pattern matching):
Given: VAR_SET=canary and VAR_NOT_SET not defined
it passes using [[ "${VAR_SET}" == can* ]] # VAR_SET: canary
correctly fails using [[ "${VAR_SET}" == cannot* ]] # VAR_SET: canary

## != operator tests:
Given: VAR_SET=canary and VAR_NOT_SET not defined
correctly fails using [ "${VAR_SET}" != "canary" ] # VAR_SET: canary
correctly fails using [[ "${VAR_SET}" != "canary" ]] # VAR_SET: canary
it passes using [ "${VAR_NOT_SET}" != "canary" ] # VAR_NOT_SET:
it passes using [[ "${VAR_NOT_SET}" != "canary" ]] # VAR_NOT_SET:

## -n operator tests (not null):
Given: VAR_SET=canary and VAR_NOT_SET not defined
it passes using [ -n "${VAR_SET}" ] # VAR_SET: canary
it passes using [[ -n "${VAR_SET}" ]] # VAR_SET: canary
correctly fails using [ -n "${VAR_NOT_SET}" ] # VAR_NOT_SET:
correctly fails using [[ -n "${VAR_NOT_SET}" ]] # VAR_NOT_SET:

## -z operator tests (is null):
Given: VAR_SET=canary and VAR_NOT_SET not defined
correctly fails using [ -z "${VAR_SET}" ] # VAR_SET: canary
correctly fails using [[ -z "${VAR_SET}" ]] # VAR_SET: canary
it passes using [ -z "${VAR_NOT_SET}" ] # VAR_NOT_SET:
it passes using [[ -z "${VAR_NOT_SET}" ]] # VAR_NOT_SET:

## =~ operator tests (regex matching):
Given: VAR_TEXT=a string with a canary in it
it passes using [[ "${VAR_TEXT}" =~ .*canary.* ]]
it passes using [[ "${VAR_TEXT}" =~ canary.* ]]
it passes using [[ "${VAR_TEXT}" =~ canary ]]
it passes using [[ "${VAR_TEXT}" =~ ca..ry ]]
```

### arithmetic comparisons

The `(( ... ))` [double parentheses](https://tldp.org/LDP/abs/html/dblparens.html)
and [let ...](https://tldp.org/LDP/abs/html/internal.html#LETREF)
constructs return an exit status, according to whether the arithmetic expressions they evaluate expand to a non-zero value. These arithmetic-expansion constructs may therefore be used to perform arithmetic comparisons.

### File tests

The [file test operators](https://tldp.org/LDP/abs/html/fto.html) are used to test a whole range of file an driectory properties.
Most commonly:

* `-e` file exists
* `-f` file is a regular file (not a directory or device file)
* `-d` file is a directory
* `!` to negate any file test operator

Running the example [test_files.sh](./test_string_variables.sh) script:

```
$ ./test_files.sh

# -e operator tests (file exists):
correctly returns true for [ -e "./test_files.sh" ]
correctly returns false for [ -e "./bogative.sh" ]

# ! -e operator tests (not file exists):
correctly returns true for [ ! -e "./bogative.sh" ]

# -f operator tests (is a file):
correctly returns true for [ -f "./test_files.sh" ]
correctly returns false for [ -f "../if_and_test" ]
correctly returns false for [ -f "./bogative.sh" ]

# -d operator tests (is a directory):
correctly returns true for [ -d "../if_and_test" ]
correctly returns false for [ -d "./test_files.sh" ]
correctly returns false for [ -d "./bogative.sh" ]
```

## Credits and References

* [Advanced Bash-Scripting Guide: Tests](https://tldp.org/LDP/abs/html/tests.html)
* [Advanced Bash-Scripting Guide: comparison operators](https://tldp.org/LDP/abs/html/comparison-ops.html)
