# #423 majorityElement

Using Idris 2 to find the majority element in an array; cassidoo's interview question of the week (2026-03-02).

## Notes

The [interview question of the week (2026-03-02)](https://buttondown.com/cassidoo/archive/u1f6f5-the-way-to-right-wrongs-is-to-turn-the/)
asks us to find the maximum sub-array sum:

> Find the majority element in an array (one that appears more than n/2 times) in O(n) time and O(1) space without hashmaps. Hint: the Boyer-Moore Voting algorithm might help if you can't figure this one out!
>
> Example:
>
> ```ts
> > majorityElement([2, 2, 1, 1, 2, 2, 1, 2, 2])
> 2
>
> > majorityElement([3, 3, 4, 2, 3, 3, 1])
> 3
> ```

## Thinking about the Problem

The goal is to find the majority element in a list—an element that appears more than half the time.
This is what the [Boyer–Moore majority vote algorithm](https://en.wikipedia.org/wiki/Boyer%E2%80%93Moore_majority_vote_algorithm) is designed for:

> The Boyer–Moore majority vote algorithm is an algorithm for finding the majority of a sequence of elements using linear time and a constant number of words of memory.
> It is named after Robert S. Boyer and J Strother Moore, who published it in 1981, and is a prototypical example of a streaming algorithm.

### Using Idris

See [LCK#420 About Idris](../about/) for my introduction to Idris.

I'm using a version installed with homebrew on macOS:

```sh
$ idris2 --version
Idris 2, version 0.8.0
```

### A First Go

This function implements the Boyer–Moore majority vote algorithm in Idris 2.

```idris
majorityElement : List Integer -> Integer
majorityElement xs = bm xs 0 0
  where
    bm : List Integer -> Integer -> Integer -> Integer
    bm [] candidate _ = candidate
    bm (n :: rest) candidate count =
      if count == 0
        then bm rest n 1
        else if n == candidate
          then bm rest candidate (count + 1)
          else bm rest candidate (count - 1)
```

Explained:

* majorityElement takes a list of integers and returns an integer
* entrypoint calls a helper function `bm` with:
    * `xs` : the input list
    * `0` : initial candidate
    * `0` : initial count
* When the list is empty: return the current candidate
* Recursively shifts head element to `n`
    * if the `count` is 0, choose `n` as a new candidate
    * if `n` matches the candidate it gets a vote, else loses a vote
* The key idea is that majority elements cannot be fully cancelled out and will be the only candidate to survive.

Testing interactively:

```sh
$ idris2 challenge.idr
     ____    __     _         ___
    /  _/___/ /____(_)____   |__ \
    / // __  / ___/ / ___/   __/ /     Version 0.8.0
  _/ // /_/ / /  / (__  )   / __/      https://www.idris-lang.org
 /___/\__,_/_/  /_/____/   /____/      Type :? for help

Welcome to Idris 2.  Enjoy yourself!
1/1: Building challenge (challenge.idr)
Main> majorityElement([2, 2, 1, 1, 2, 2, 1, 2, 2])
2
Main> majorityElement([3, 3, 4, 2, 3, 3, 1])
3
Main> majorityElement([1, 2, 3])
3
Main> :q
Bye for now!
```

OK, it's finding the majority successfully, but where there is no majority element, it is just returning the last candidate.

### Handling the Case of No Majority

We check and maybe return Nothing:

```idris
majorityElement : List Integer -> Maybe Integer
majorityElement xs =
  let candidate = bm xs 0 0
      count = cast (length (filter (== candidate) xs))
  in if count > cast (length xs) `div` 2 then Just candidate else Nothing
  where
    bm : List Integer -> Integer -> Integer -> Integer
    bm [] candidate _ = candidate
    bm (n :: rest) candidate count =
      if count == 0
        then bm rest n 1
        else if n == candidate
          then bm rest candidate (count + 1)
          else bm rest candidate (count - 1)
```

That's better, but note our function result has changed changed to indicate maybe no integer is returned.
We'll clean this up when printing the result.

```sh
$ idris2 challenge.idr
     ____    __     _         ___
    /  _/___/ /____(_)____   |__ \
    / // __  / ___/ / ___/   __/ /     Version 0.8.0
  _/ // /_/ / /  / (__  )   / __/      https://www.idris-lang.org
 /___/\__,_/_/  /_/____/   /____/      Type :? for help

Welcome to Idris 2.  Enjoy yourself!
Main> majorityElement([2, 2, 1, 1, 2, 2, 1, 2, 2])
Just 2
Main> majorityElement([3, 3, 4, 2, 3, 3, 1])
Just 3
Main> majorityElement([1, 2, 3])
Nothing
Main> :q
Bye for now!
```

Compiling and running the examples. All good:

```sh
$ idris2 challenge.idr -o majority-element
$ build/exec/majority-element "2, 2, 1, 1, 2, 2, 1, 2, 2"
2
$ build/exec/majority-element "3, 3, 4, 2, 3, 3, 1"
3
$ build/exec/majority-element "1, 2, 3"
No majority element
```

### Example Code

Final code is in [challenge.idr](./challenge.idr):

```idris
module Main

import System
import Data.List
import Data.String

majorityElement : List Integer -> Maybe Integer
majorityElement xs =
  let candidate = bm xs 0 0
      count = cast (length (filter (== candidate) xs))
  in if count > cast (length xs) `div` 2 then Just candidate else Nothing
  where
    bm : List Integer -> Integer -> Integer -> Integer
    bm [] candidate _ = candidate
    bm (n :: rest) candidate count =
      if count == 0
        then bm rest n 1
        else if n == candidate
          then bm rest candidate (count + 1)
          else bm rest candidate (count - 1)

parseArray : String -> List Integer
parseArray s = mapMaybe parseInteger (split (== ',') (trim s))
  where
    dropWhileEnd : (a -> Bool) -> List a -> List a
    dropWhileEnd p = foldr (\x, xs => if p x && isNil xs then [] else x :: xs) []
    trim : String -> String
    trim = pack . dropWhile isSpace . dropWhileEnd isSpace . unpack
    split : (Char -> Bool) -> String -> List String
    split p s = case break p (unpack s) of
      (a, []) => [pack a]
      (a, _ :: b) => pack a :: split p (pack b)

main : IO ()
main = do
  args <- getArgs
  case args of
    [_, input] => do
      let arr = parseArray input
      let result = majorityElement arr
      case result of
        Just n => putStrLn (show n)
        Nothing => putStrLn ("No majority element")
    _ => putStrLn "Usage: majority-element <comma-separated-numbers>"
```

## Credits and References

* [cassidoo's interview question of the week (2026-03-02)](https://buttondown.com/cassidoo/archive/u1f6f5-the-way-to-right-wrongs-is-to-turn-the/)
* [LCK#420 About Idris](../about/)
* <https://en.wikipedia.org/wiki/Boyer%E2%80%93Moore_majority_vote_algorithm>
* <https://www.geeksforgeeks.org/theory-of-computation/boyer-moore-majority-voting-algorithm/>
