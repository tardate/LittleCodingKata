# #477 climbStairs

Using pascal to climb stairs; cassidoo's interview question of the week (2026-08-31).

## Notes

The [interview question of the week (2026-08-31)](https://buttondown.com/cassidoo/archive/u1f490-if-you-see-someone-without-a-smile-today/):

> Given an integer n representing the number of steps in a staircase, return the number of distinct ways you can reach the top if you can climb either 1 or 2 steps at a time.
>
> Example:
>
> ```ts
> climbStairs(2)
> > 2
>
> climbStairs(4)
> > 5
>
> climbStairs(10)
> > 89
> ```

### Thinking about the Problem

This smells very much like a simple problem in permutations and combinations.

To reach step n, the previous move must have been either:

* a 1-step move from n-1, or
* a 2-step move from n-2.

Therefore `f(n)=f(n-1)+f(n-2)` with `f(0)=1`, `f(1)=1`. So:

|  n | ways |
| -: | ---: |
|  0 |    1 |
|  1 |    1 |
|  2 |    2 |
|  3 |    3 |
|  4 |    5 |
|  5 |    8 |
|  6 |   13 |
|  7 |   21 |

And that is... the [Fibonacci sequence](https://en.wikipedia.org/wiki/Fibonacci_sequence).

### A First Go

Using Pascal this time with a simple Fibonacci algorithm to iteratively sum the preceding two elements:

```pascal
function ClimbStairs(n: Integer): Int64;
var
  a, b, next: Int64;
  i: Integer;
begin
  a := 1;  // f(0)
  b := 1;  // f(1)

  for i := 1 to n do
  begin
    next := a + b;
    a := b;
    b := next;
  end;

  ClimbStairs := a;
end;
```

Compile with `fpc`, the [Free Pascal](../free_pascal/) compiler:

```sh
$ fpc challenge.pp
Free Pascal Compiler version 3.2.2 [2025/09/11] for aarch64
Copyright (c) 1993-2021 by Florian Klaempfl and others
Target OS: Darwin for AArch64
Compiling challenge.pp
Assembling challenge
Linking challenge
-macosx_version_min has been renamed to -macos_version_min
ld: warning: -multiply_defined is obsolete
37 lines compiled, 0.6 sec
```

Let's try...

```sh
$ ./challenge
Usage: challenge <n>
$ ./challenge 2
2
$ ./challenge 4
5
$ ./challenge 10
89
```

Looking good!

### Final Code

[challenge.pp](./challenge.pp):

```pascal
program challenge;

uses
  SysUtils;

function ClimbStairs(n: Integer): Int64;
var
  a, b, next: Int64;
  i: Integer;
begin
  a := 1;  // f(0)
  b := 1;  // f(1)

  for i := 1 to n do
  begin
    next := a + b;
    a := b;
    b := next;
  end;

  ClimbStairs := a;
end;

var
  n: Integer;

begin
  if ParamCount < 1 then
  begin
    WriteLn('Usage: challenge <n>');
    Halt(1);
  end;

  n := StrToInt(ParamStr(1));

  WriteLn(ClimbStairs(n));
end.
```

## Credits and References

* [Free Pascal](../free_pascal/)
* [Fibonacci sequence](https://en.wikipedia.org/wiki/Fibonacci_sequence)
