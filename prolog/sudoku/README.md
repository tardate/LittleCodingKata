# #xxx Solving Sudoku with Prolog

Using Prolog to solve sudoku-style problems

## Notes

This is an exercise from [Seven Languages in Seven Weeks](../../books/seven-languages-in-seven-weeks/).

See [sudoku4x4.pl](./sudoku4x4.pl) for the full source. Here it is with annotated explanation:

### 1. Validation Rules

Ensures that each list in a list of lists contains all *different* numbers

* Using the `valid/1` predicate
* The base case: an empty list is trivially valid.
* If the first element (`Head`) of the list of lists satisfies `fd_all_different/1` (all elements in it are different),
* then recursively check the rest of the lists (`Tail`).

```prolog
valid([]).
valid([Head|Tail]) :- fd_all_different(Head), valid(Tail).
```

### 2. The main `sudoku/2` predicate

Allow the user to pass in a partially filled puzzle (with some known numbers) and get the `Solution` back filled in.

* `Puzzle` and `Solution` are unified:

```prolog
sudoku(Puzzle, Solution) :-
  Solution = Puzzle,
```

#### The 16 Sudoku variables

These represent the 4×4 Sudoku grid:

```prolog
  Puzzle = [S11, S12, S13, S14,
            S21, S22, S23, S24,
            S31, S32, S33, S34,
            S41, S42, S43, S44],
```

#### Set the domain of possible values

Each Sudoku cell (`Sij`) can take any integer from **1 to 4**:

```prolog
  fd_domain(Solution, 1, 4),
```

#### Define rows

Each row is defined as a list of four variables:

```prolog
  Row1 = [S11, S12, S13, S14],
  Row2 = [S21, S22, S23, S24],
  Row3 = [S31, S32, S33, S34],
  Row4 = [S41, S42, S43, S44],
```

#### Define columns

Each column collects one cell from each row:

```prolog
  Col1 = [S11, S21, S31, S41],
  Col2 = [S12, S22, S32, S42],
  Col3 = [S13, S23, S33, S43],
  Col4 = [S14, S24, S34, S44],
```

#### Define 2×2 squares (subgrids)

Defines each smaller 2×2 block:

```prolog
  Square1 = [S11, S12, S21, S22],
  Square2 = [S13, S14, S23, S24],
  Square3 = [S31, S32, S41, S42],
  Square4 = [S33, S34, S43, S44],
```

#### Apply the constraints

Uses the `valid/1` predicate to enforce that all rows, columns, and squares have unique values (no duplicates).

Note: The actual solving (searching for values) happens implicitly when Prolog tries to satisfy all constraints.

```prolog
  valid([Row1, Row2, Row3, Row4,
         Col1, Col2, Col3, Col4,
         Square1, Square2, Square3, Square4]).
```

### 3. Printing the Sudoku

#### Entry point for printing

* Verifies `List` has 16 elements (a 4×4 grid).
* Then calls `print_rows/2` to display it row by row.

```prolog
print_sudoku(List) :-
    length(List, 16),
    print_rows(List, 0).
```

#### Recursive printer

Base case: stop when no more cells to print:

```prolog
print_rows([], _).
```

Print the list, element by element:

* Prints each number (`Head`).
* After every 4th element (`Count mod 4 =:= 3`), prints a newline (`nl`), otherwise adds a few spaces (`tab(3)`).
* Recursively prints the rest of the list.

```prolog
print_rows([Head|Tail], Count) :-
    write('    '),
    write(Head),
    (Count mod 4 =:= 3 -> nl ; tab(3)),
    NewCount is Count + 1,
    print_rows(Tail, NewCount).
```

### 4. Combine everything

Solves the Sudoku and then prints the result:

```prolog
solve_and_print(Sudoku) :-
  sudoku(Sudoku, Solution),
  print_sudoku(Solution).
```

## Checking Results

```sh
$ gprolog --consult-file sudoku4x4.pl
GNU Prolog 1.5.0 (64 bits)
Compiled Jul  8 2021, 09:35:47 with clang
Copyright (C) 1999-2024 Daniel Diaz

compiling ./sudoku4x4.pl for byte code...
./sudoku4x4.pl compiled, 45 lines read - 6727 bytes written, 3 ms
```

Running some tests:

```prolog
| ?- solve_and_print([_, _, 2, 3,
                      _, _, _, _,
                      _, _, _, _,
                      3, 4, _, _]).
    4       1       2       3
    2       3       4       1
    1       2       3       4
    3       4       1       2

yes
| ?- solve_and_print([1, _, 3, _,
                      _, _, _, _,
                      _, _, _, _,
                      4, 2, _, _]).
    1       4       3       2
    2       3       4       1
    3       1       2       4
    4       2       1       3

yes
```

NB: can also run directly from the command line:

```sh
$ gprolog --consult-file sudoku4x4.pl --query-goal "solve_and_print([_, _, 2, 3, _, _, _, _, _, _, _, _, 1, 2, _, _]), nl, halt"
GNU Prolog 1.5.0 (64 bits)
Compiled Jul  8 2021, 09:35:47 with clang
Copyright (C) 1999-2024 Daniel Diaz

compiling /Users/paulgallagher/MyGithub/tardate/LittleCodingKata/prolog/sudoku/sudoku4x4.pl for byte code...
/Users/paulgallagher/MyGithub/tardate/LittleCodingKata/prolog/sudoku/sudoku4x4.pl compiled, 45 lines read - 6727 bytes written, 4 ms
| ?- solve_and_print([_, _, 2, 3, _, _, _, _, _, _, _, _, 1, 2, _, _]), nl, halt.
    4       1       2       3
    2       3       4       1
    3       4       1       2
    1       2       3       4

```

## Extending to a 9x9 Solver

See [sudoku9x9.pl](./sudoku9x9.pl) - constructed the same way as 4x4, just bigger!

Testing a solve:

```sh
$ gprolog --consult-file sudoku9x9.pl
GNU Prolog 1.5.0 (64 bits)
Compiled Jul  8 2021, 09:35:47 with clang
Copyright (C) 1999-2024 Daniel Diaz

compiling ./sudoku9x9.pl for byte code...
./sudoku9x9.pl compiled, 67 lines read - 21234 bytes written, 6 ms

| ?- solve_and_print([9, _, 5, _, 4, 7, 2, 1, 6,
2, _, 7, _, 3, 6, 8, _, 9,
8, 6, _, 2, 1, 9, 5, 7, _,
1, 9, _, 4, 7, 3, _, 5, 2,
_, 4, 6, _, 2, 5, _, 3, 8,
_, _, 3, 1, _, 8, 4, _, 7,
_, 5, 2, 7, 8, 4, 9, 6, _,
6, 8, 9, 3, 5, 1, 7, 2, 4,
4, 7, 1, 6, 9, 2, 3, 8, _]).
    9       3       5       8       4       7       2       1       6
    2       1       7       5       3       6       8       4       9
    8       6       4       2       1       9       5       7       3
    1       9       8       4       7       3       6       5       2
    7       4       6       9       2       5       1       3       8
    5       2       3       1       6       8       4       9       7
    3       5       2       7       8       4       9       6       1
    6       8       9       3       5       1       7       2       4
    4       7       1       6       9       2       3       8       5

yes
```

## Credits and References

* [Seven Languages in Seven Weeks](../../books/seven-languages-in-seven-weeks/) - Chapter 4: Prolog
* <https://en.wikipedia.org/wiki/Sudoku>
* [Symbolic constraint: fd_all_different/1](http://www.gprolog.org/manual/html_node/gprolog062.html#sec326)
* [Initial value constraints: fd_domain/2](http://www.gprolog.org/manual/html_node/gprolog057.html#sec309)
* a 4x4, 9x9, 16x16 generator: <https://github.com/mateus-po/sudoku-generator>
* a 9x9 generator: <https://htmlpreview.github.io/?https://github.com/robatron/sudoku.js/blob/master/demo/index.html>
