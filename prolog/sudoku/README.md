# #390 Solving Sudoku with Prolog

Using Prolog to solve sudoku-style problems

## Notes

This is an exercise from [Seven Languages in Seven Weeks](../../books/seven-languages-in-seven-weeks/).

## A 4x4 Solver

To get a handle on the challenge, starting with a 4x4 [sudoku](https://en.wikipedia.org/wiki/Sudoku) solver.

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

### 2. The main sudoku predicate

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

#### Define 2×2 squares (sub-grids)

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

## A 16x16 Solver?

This is getting a little extreme, but let's extend this to a 16x16 solver.
See [sudoku16x16.pl](./sudoku16x16.pl).

I'm going to enter the values in decimal (0..15) but I want the result printed in hexadecimal (0..F).
I could enter in hex, but I've have to use the even more inconvenient form with a prefix e.g. 0xF.

```sh
$ gprolog --consult-file sudoku16x16.pl
GNU Prolog 1.5.0 (64 bits)
Compiled Jul  8 2021, 09:35:47 with clang
Copyright (C) 1999-2024 Daniel Diaz

compiling ./sudoku16x16.pl for byte code...
./sudoku16x16.pl compiled, 106 lines read - 59065 bytes written, 19 ms

| ?- solve_and_print([_, 4, _, 15, 2, _, 0, _, _, 6, _, 1, 7, _, 5, _,
_, 3, _, _, _, 1, 7, 8, 0, 12, 10, _, _, _, 2, _,
_, 10, 0, 1, 4, _, 9, 11, 5, 7, 2, 8, _, 14, 3, _,
11, 2, 14, 7, _, 5, 6, _, 3, 4, 9, _, 8, 0, _, 1,
_, 11, 2, 5, 0, 9, 1, 6, 4, _, 3, 7, 14, 12, 8, _,
_, 15, 6, 3, 11, 8, 2, 4, _, _, _, 5, _, 13, 1, 7,
8, _, _, _, _, 7, _, _, _, _, 13, _, _, _, _, 5,
7, _, _, _, 5, _, 15, _, _, 2, _, 9, _, _, _, _,
15, 13, _, 9, 12, 6, _, _, _, _, 1, 10, 0, _, 7, 14,
_, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _,
10, _, 11, 4, _, _, 14, _, _, 9, _, _, 13, 8, _, 3,
_, _, 12, _, _, 3, 4, 0, 6, 5, 7, _, _, 11, _, _,
0, _, 15, 6, _, _, _, _, _, _, _, _, 1, 2, _, 8,
9, _, _, _, _, _, 3, 7, 8, 0, _, _, _, _, _, 13,
3, 1, _, 11, 13, 0, _, _, _, _, 15, 2, 6, _, 12, _,
4, 7, 13, 8, _, _, _, 2, 10, _, _, _, 3, 9, _, _]).
    C       4       8       F       2       _#34(13..14)       0       _#51(3:13..14)       _#68(11:13..14)       6       _#85(11:14)       1       7       A       5       _#119(9:11)
    5       3       9       D       _#187(14..15)       1       7       8       0       C       A       _#204(11:14..15)       _#221(4:11:15)       _#238(6:15)       2       _#255(6:11:15)
    6       A       0       1       4       _#289(12..13:15)       9       B       5       7       2       8       _#306(12:15)       E       3       _#323(12:15)
    B       2       E       7       _#340(10:15)       5       6       _#357(10:12..13:15)       3       4       9       _#374(13:15)       8       0       _#391(13:15)       1
    D       B       2       5       0       9       1       6       4       F       3       7       E       C       8       A
    E       F       6       3       B       8       2       4       C       A       0       5       9       D       1       7
    8       _#544(0:9:12)       _#561(1:4:10)       _#578(0:10:12)       _#595(3:10:14)       7       _#612(10:12)       _#629(3:10:12:14)       _#646(1:11:14)       _#663(1:11)       D       _#680(6:11:14)       _#697(2:4:11:15)       _#714(3:6:15)       _#731(0:4:6:11:15)       5
    7       _#748(0:12)       _#765(1:4:10)       _#782(0:10:12)       5       _#799(10:12..14)       F       _#816(3:10:12..14)       _#833(1:11:14)       2       _#850(6:8:11:14)       9       _#867(4:11)       _#884(3:6)       _#901(0:4:6:11)       _#918(0:6:11)
    F       D       3       9       C       6       _#952(8:11)       5       _#986(2:11)       _#1003(8:11)       1       A       0       4       7       E
    _#1037(1..2)       _#1054(0:5..6:8:14)       _#1071(1:5:7)       _#1088(0:2:14)       _#1105(1:7..10:15)       _#1122(2:10..11:13:15)       _#1139(8:10..11:13)       _#1156(1:9..10:13:15)       _#1173(2:11:13..15)       _#1190(3:8:11:13)       _#1207(4:8:11:14)       _#1224(0:3..4:11:13..15)       _#1241(2:5:10:12:15)       _#1258(1:5..6:15)       _#1275(6:9..10:15)       _#1292(2:6:9:12:15)
    A       _#1309(0:5..6)       B       4       _#1326(1:7:15)       _#1343(2:15)       E       _#1360(1:15)       _#1377(2:15)       9       C       _#1411(0:15)       D       8       _#1428(6:15)       3
    _#1445(1..2)       _#1462(8:14)       C       _#1479(2:14)       _#1496(1:8..10:15)       3       4       0       6       5       7       _#1513(13..15)       _#1530(2:10:15)       B       _#1547(9..10:15)       _#1564(2:9:15)
    0       _#1581(5:12:14)       F       6       _#1598(9..10:14)       _#1615(4:10..12:14)       _#1632(5:10..12)       _#1649(9..10:12:14)       _#1666(7:9:11:13)       _#1683(3:11:13)       _#1700(4..5:11)       _#1717(3..4:11..13)       1       2       _#1734(10..11:14)       8
    9       _#1751(5:12:14)       _#1768(5:10)       _#1785(2:10:12:14)       _#1802(1:6:10:14..15)       _#1819(4:10..12:14..15)       3       7       8       0       _#1836(4..6:11)       _#1853(4:6:11..12)       _#1870(5:10..11:15)       _#1887(5:15)       _#1904(10..11:14..15)       D
    3       1       _#1921(5:10)       B       D       0       _#1938(5:8:10)       _#1955(9..10)       _#1972(7:9)       E       F       2       6       _#2006(5:7)       C       4
    4       7       D       8       _#2040(1:6:14..15)       _#2057(11..12:14..15)       _#2074(5:11..12)       2       A       _#2091(1:11)       _#2108(5..6:11)       _#2125(6:11..12)       3       9       _#2142(0:11:14..15)       _#2159(0:11:15)

(1 ms) yes
```

OK, we don't have enough information in the square to find a unique solution in one go. Here Prolog is returning the possible ranges.

Let's break the tie and try `_#34(13..14)` as 14 i.e. 0xE:

```sh
| ?- solve_and_print([_, 4, _, 15, 2, 14, 0, _, _, 6, _, 1, 7, _, 5, _,
_, 3, _, _, _, 1, 7, 8, 0, 12, 10, _, _, _, 2, _,
_, 10, 0, 1, 4, _, 9, 11, 5, 7, 2, 8, _, 14, 3, _,
11, 2, 14, 7, _, 5, 6, _, 3, 4, 9, _, 8, 0, _, 1,
_, 11, 2, 5, 0, 9, 1, 6, 4, _, 3, 7, 14, 12, 8, _,
_, 15, 6, 3, 11, 8, 2, 4, _, _, _, 5, _, 13, 1, 7,
8, _, _, _, _, 7, _, _, _, _, 13, _, _, _, _, 5,
7, _, _, _, 5, _, 15, _, _, 2, _, 9, _, _, _, _,
15, 13, _, 9, 12, 6, _, _, _, _, 1, 10, 0, _, 7, 14,
_, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _,
10, _, 11, 4, _, _, 14, _, _, 9, _, _, 13, 8, _, 3,
_, _, 12, _, _, 3, 4, 0, 6, 5, 7, _, _, 11, _, _,
0, _, 15, 6, _, _, _, _, _, _, _, _, 1, 2, _, 8,
9, _, _, _, _, _, 3, 7, 8, 0, _, _, _, _, _, 13,
3, 1, _, 11, 13, 0, _, _, _, _, 15, 2, 6, _, 12, _,
4, 7, 13, 8, _, _, _, 2, 10, _, _, _, 3, 9, _, _]).
    C       4       8       F       2       E       0       3       D       6       B       1       7       A       5       9
    5       3       9       D       F       1       7       8       0       C       A       E       4       6       2       B
    6       A       0       1       4       D       9       B       5       7       2       8       C       E       3       F
    B       2       E       7       A       5       6       C       3       4       9       F       8       0       D       1
    D       B       2       5       0       9       1       6       4       F       3       7       E       C       8       A
    E       F       6       3       B       8       2       4       C       A       0       5       9       D       1       7
    8       9       4       C       3       7       A       E       1       B       D       6       2       F       0       5
    7       0       1       A       5       C       F       D       E       2       8       9       B       3       4       6
    F       D       3       9       C       6       B       5       2       8       1       A       0       4       7       E
    2       6       7       0       8       A       D       F       B       3       E       4       5       1       9       C
    A       5       B       4       7       2       E       1       F       9       C       0       D       8       6       3
    1       8       C       E       9       3       4       0       6       5       7       D       A       B       F       2
    0       C       F       6       E       B       5       9       7       D       4       3       1       2       A       8
    9       E       A       2       1       4       3       7       8       0       6       C       F       5       B       D
    3       1       5       B       D       0       8       A       9       E       F       2       6       7       C       4
    4       7       D       8       6       F       C       2       A       1       5       B       3       9       E       0

(1 ms) yes
```

And we have a solution!

## Credits and References

* [Seven Languages in Seven Weeks](../../books/seven-languages-in-seven-weeks/) - Chapter 4: Prolog
* <https://en.wikipedia.org/wiki/Sudoku>
* [Symbolic constraint: fd_all_different/1](http://www.gprolog.org/manual/html_node/gprolog062.html#sec326)
* [Initial value constraints: fd_domain/2](http://www.gprolog.org/manual/html_node/gprolog057.html#sec309)
* a 4x4, 9x9, 16x16 generator: <https://github.com/mateus-po/sudoku-generator>
* a 9x9 generator: <https://htmlpreview.github.io/?https://github.com/robatron/sudoku.js/blob/master/demo/index.html>
