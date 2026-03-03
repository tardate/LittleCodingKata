# #420 About Idris

An overview of the Idris 2 programming language, its features, and ecosystem. Includes setting up and running on macOS.

## Notes

Idris features in Bruce Tate's [Seven More Languages in Seven Weeks](../../books/seven-more-languages-in-seven-weeks/).

Note that the book covers Idris 1. Idris 1 is no longer maintained but remains available.
Idris 2 is a reimplementation focused on performance and practicality, and is still actively maintained and developed.

### Idris In a Nutshell

Idris is..

* **A purely functional programming language** with full dependent types.
* **A general-purpose language** designed for writing correct-by-construction software.
* **Strongly and statically typed**, with types checked at compile time.
* **Inspired by Haskell and ML**, but with first-class dependent types similar to those in proof assistants.
* **Designed to blur the line between programming and theorem proving**, enabling programs and proofs to coexist.
* Currently developed primarily as **Idris 2**, a reimplementation focused on performance and practicality.

Idris has..

* **Full dependent types**, allowing types to depend on values (e.g., encoding invariants like list lengths in the type system).
* **Totality checking**, ensuring functions are total (no partial functions or infinite loops unless explicitly allowed).
* **Interactive development tooling**, including a REPL and editor integrations that assist with proof and type-driven development.
* **Pattern matching and algebraic data types**, similar to Haskell.
* **Type inference with explicit control**, letting developers mix concise and precise type specifications.
* **Foreign Function Interface (FFI)** support for integration with C and other systems.
* **Multiple backends** (in Idris 2), including compilation to Scheme, C, JavaScript, and others.
* A **small but academically active ecosystem**, with libraries for effects, parsing, web development experiments, and systems programming.

Idris is governed by..

* An **open-source development model**, hosted on GitHub.
* The **Idris 2 core team and contributors**, led originally by its creator, Edwin Brady.
* Community discussions via GitHub issues, mailing lists, and chat platforms.
* A research-oriented but practical philosophy, balancing **type theory research** with real-world programming concerns.

### Seven More Languages in Seven Weeks: Wrapping Up Idris

Core Strengths:

* With Idris, types know more, so they can do more.
* compilers can catch more complex bugs, including logic errors, at compile time.
* types can express structure, so automatic code completion can go far beyond basic syntax
* information about types allows better proofs, ideal in fields such as protocols and cryptography

Core Weaknesses:

* dependent types take effort to express them.
* learning curve is steep
* few examples beyond simple tutorials

## Test drive: Idris on macOS

Idris can be installed

* from [source](https://www.idris-lang.org/pages/download.html)
* using [pack](https://github.com/stefan-hoeck/idris2-pack) - the Idris2 Package Manager with Curated Package Collections
    * best for real projects
* using [docker](https://github.com/joshuanianji/idris-2-docker)
* using [homebrew](https://formulae.brew.sh/formula/idris2)
    * good for quick install and casual use

I'll start with a simple `brew install idris2`

```sh
$ idris2 --version
Idris 2, version 0.8.0
$ idris2
     ____    __     _         ___
    /  _/___/ /____(_)____   |__ \
    / // __  / ___/ / ___/   __/ /     Version 0.8.0
  _/ // /_/ / /  / (__  )   / __/      https://www.idris-lang.org
 /___/\__,_/_/  /_/____/   /____/      Type :? for help

Welcome to Idris 2.  Enjoy yourself!
Main>
Main> :t map
Prelude.map : Functor f => (a -> b) -> f a -> f b
Main> map (\x => x * 0.5) (the (List Double) [3.14, 2.78])
[1.57, 1.39]
```

### Example: Leap Year Test

See [is_leap_year.idr](./is_leap_year.idr) for an implementation if `isLeap`:

```idris
isLeap : Int -> Bool
isLeap year =
  (year `mod` 400 == 0) ||
  ((year `mod` 4 == 0) && (year `mod` 100 /= 0))
```

Testing it from the REPL:

```sh
$ idris2 is_leap_year.idr
     ____    __     _         ___
    /  _/___/ /____(_)____   |__ \
    / // __  / ___/ / ___/   __/ /     Version 0.8.0
  _/ // /_/ / /  / (__  )   / __/      https://www.idris-lang.org
 /___/\__,_/_/  /_/____/   /____/      Type :? for help

Welcome to Idris 2.  Enjoy yourself!
Main> isLeap 2024
True
Main> isLeap 2026
False
```

i've added main function and argument parsing so can compile and run as an executable:

```sh
$ idris2 is_leap_year.idr -o is_leap_year
$ ./build/exec/is_leap_year
Usage: is_leap_year (year) - check if year is a leap year
$ ./build/exec/is_leap_year 2026
false
$ ./build/exec/is_leap_year 2028
true
```

Full source of [is_leap_year.idr](./is_leap_year.idr):

```idris
module Main

import System
import Data.String
import Data.Maybe

isLeap : Int -> Bool
isLeap year =
  (year `mod` 400 == 0) ||
  ((year `mod` 4 == 0) && (year `mod` 100 /= 0))

main : IO ()
main = do
  args <- getArgs
  case args of
    [] => putStrLn "Usage: (year) - check if year is a leap year"
    (progName :: rest) => do
      case rest of
        [yearStr] =>
          case parseInteger yearStr of
            Just year  => putStrLn (if isLeap (cast year) then "true" else "false")
            Nothing => putStrLn "invalid parameter"
        _ => putStrLn "Usage: is_leap_year (year) - check if year is a leap year"

```

## Credits and References

* <https://www.idris-lang.org/>
<https://github.com/idris-lang/Idris2>
<https://github.com/stefan-hoeck/idris2-pack>
* [Seven More Languages in Seven Weeks](../../books/seven-more-languages-in-seven-weeks/) - Chapter 7: Idris
