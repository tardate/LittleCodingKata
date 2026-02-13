# #412 moveNums

Using Factor to rearrange an array; cassidoo's interview question of the week (2026-02-09).

## Notes

The [interview question of the week (2026-02-09)](https://buttondown.com/cassidoo/archive/everyone-deserves-the-space-to-change-and-for/)
asks us rearrange an array:

> Given an integer array and a number n, move all of the ns to the end of the array while maintaining the relative order of the non-ns. Bonus: do this without making a copy of the array!
>
> Example:
>
> ```ts
> moveNums([0,2,0,3,10], 0)
> [2,3,10,0,0]
> ```

## Thinking about the Problem

An idiomatic approach would be to partition the array and split into "not n" and "n" and then append.
While clear and correct, it allocates one or two new sequences.

To solve in-place per the bonus challenge:

* requires a mutable sequence (e.g. vector)
* use two indices: read i and write w.
* For each element, if seq[i] != n, write it to seq[w] and increment w.
* Then fill indices w to end with n.

### Using Factor

See [LCK#411 About Factor](../about/) for my introduction to Factor.

I'm using an installation built from source, so I'll export an environment variable to make it easy to reference:

```sh
export FACTOR_BASE="$(pwd)/../about/factor-source"
```

### A First Go

The idiomatic partition approach appears to be well suited to Factor’s stack-based, concatenation style: data flows through words, and composition builds the solution. So while this won't win the bonus award, it should be an interesting exercise.

... and it turns out to be quite neat. Here's a "full" implementation of the solution:

```factor
: movNums ( seq n -- seq' )
    [ = ] curry partition swap append ;
```

Explained:

* the function `movNums` takes a sequence and a number n, returns a new sequence.

* `[ = ]` creates a quotation (anonymous function) that compares the top of the stack to the second item
* `curry` — partially applies the quotation using the value below it on the stack
    * So the stack `seq n [ = ]` becomes `seq [ n = ]` (a sequence, and a quotation that compares an element to n)
* `partition` — takes the sequence and a quotation, splits into two sequences:
    * one of the elements where the predicate is true, the other where false
* `swap` — swaps the sequences
* `append` - joins the sequence into one return value

Using the example provided, here's how that would work:

* Given: `{ 0 2 0 3 10 } 0 movNums`
* Stack: `{ 0 2 0 3 10 } 0`
* [ = ]:`{ 0 2 0 3 10 } 0 [ = ]`
* curry: `{ 0 2 0 3 10 } [ 0 = ]`
* partition: `{ 0 0 } { 2 3 10 }`
* swap: `{ 2 3 10 } { 0 0 }`
* append: `{ 2 3 10 0 0 }`

Let's run the actual code. And it works:

```sh
$ ${FACTOR_BASE}/factor -i=${FACTOR_BASE}/factor.image -roots=$(pwd) challenge/run/run.factor "0,2,0,3,10" 0
2,3,10,0,0
```

### Tests

I've setup some validation in [challenge/lib/lib-tests.factor](./challenge/lib/lib-tests.factor):

```sh
$ ${FACTOR_BASE}/factor -i=${FACTOR_BASE}/factor.image -roots=$(pwd) challenge/lib/lib-tests.factor
Unit Test: { { { 2 3 10 0 0 } } [ { 0 2 0 3 10 } 0 movNums ] }
Unit Test: { { { } } [ { } 0 movNums ] }
Unit Test: { { { 1 2 3 } } [ { 1 2 3 } 0 movNums ] }
Unit Test: { { { 0 0 0 } } [ { 0 0 0 } 0 movNums ] }
Unit Test: { { { 5 } } [ { 5 } 0 movNums ] }
Unit Test: { { { 0 } } [ { 0 } 0 movNums ] }
Unit Test: { { { 1 3 5 2 2 2 } } [ { 1 2 3 2 5 2 } 2 movNums ] }
Unit Test: { { { 0 1 2 3 4 5 } } [ { 0 1 2 3 4 5 } 99 movNums ] }
```

Running these as a test suite using [challenge/test-suite/test-suite.factor](./challenge/test-suite/test-suite.factor):

```sh
$ ${FACTOR_BASE}/factor -i=${FACTOR_BASE}/factor.image -roots=$(pwd) challenge/test-suite/test-suite.factor
All tests passed.
```

### Example Code

Final code is in [challenge/lib/lib.factor](./challenge/lib/lib.factor):

```factor
USING: kernel sequences ;
IN: challenge.lib

: movNums ( seq n -- seq' )
    [ = ] curry partition swap append ;
```

With the command line main program in [challenge/run/run.factor](./challenge/run/run.factor):

```factor
USING: challenge.lib command-line io kernel math
math.parser namespaces sequences splitting system ;
IN: challenge.run

: parse-numbers ( str -- seq )
    "," split [ string>number ] map ;

: main ( -- )
    command-line get dup length 2 < [
        "Usage: run.factor <numbers> <n>" print
        "Example: run.factor \"0 2 0 3 10\" 0" print
        1 exit
    ] [
        first2
        [ parse-numbers ] dip
        string>number
        movNums
        [ number>string ] map
        "," join
        print
    ] if ;

MAIN: main
```

## Credits and References

* [cassidoo's interview question of the week (2026-02-09)](https://buttondown.com/cassidoo/archive/everyone-deserves-the-space-to-change-and-for/)
* [LCK#411 About Factor](../about/)
