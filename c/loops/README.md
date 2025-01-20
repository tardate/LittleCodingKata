# #161 Loops in C

All about loops in C

## Notes

__notes__


### While Loops

The `while` construct has a guard condition tested on entry to loop:

```
while (condition) {
  statements;
}
```

### Do-While Loops

The `do .. while` construct has the guard condition tested at the end of the loop:

```
do {
  statements;
} while (condition);
````

### For loop

The `for` construct is a super-charged while loop, with embedded initialization and stepping of the loop control variable:

```
for (initial value; condition; incrementation or decrementation )  {
  statements;
}
```

### Break Statement

A `break` statement in a loop will immediately exit the loop.

### Continue Statement

A `continue` statement in a loop will immediately end the current loop and skip to the next iteration.

### Running the Examples

See [example.c](./example.c) for details. It runs simple tests of all combinations of syntax. A makefile compiles and runs:

```
$ make
gcc -Wall -O0    example.c   -o example
./example

===== test_while

===== test_break_while

===== test_continue_while

===== test_do_while

===== test_break_do_while

===== test_continue_do_while

===== test_for

===== test_break_for

===== test_continue_for
```

## Credits and References

* [C Loops: For, While, Do While, Looping Statements with Example](https://www.guru99.com/c-loop-statement.html)
