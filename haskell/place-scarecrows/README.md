# #xxx placeScarecrows

Using Haskell to place scarecrows in a field; cassidoo's interview question of the week (2025-10-27).

## Notes

The [interview question of the week (2025-10-27)](https://buttondown.com/cassidoo/archive/with-the-new-day-comes-new-strength-and-new/)
call for some evaluation across neighboring elements in an array:

> Given a field represented as an array of 0s and 1s, where 1 means that position needs protection, you can place a scarecrow at any index, and each scarecrow protects up to k consecutive positions centered around itself (for example, for k = 3, a scarecrow at i protects i-1, i, and i+1). Return the minimum set of indices where scarecrows should be placed so that all the positions with 1 are protected. You can assume k is an odd number (or make up what happens if it's even).
>
> ```ts
> Examples:
>
> let field = [1, 1, 0, 1, 1, 0, 1];
> let k = 3;
>
> placeScarecrows(field, k);
> > [1, 4, 6]
>
> placeScarecrows([1, 0, 1, 1, 0, 1], k)
> > [1, 4]
>
> placeScarecrows([1, 1, 1, 1, 1], 1)
> > [0, 1, 2, 3, 4]
> ```

### Thinking About the Problem

Scarecrows need to cover all unprotected parts of the field,
so intuitively it seems that we could just scan the field in a single direction (say, left to right).
Every time we encounter an unprotected cell, we just place a scarecrow as far to the right as possible, and continue scanning beyond the scarecrow's coverage.

I can't see any obvious ways to improve the technique. Let's give it a go!

### An Initial Implementation

I'm going to try some Haskell this week.

The base algorithm:

* `placeScarecrows` takes field (array of int) and k (int)
* uses a recursive worker `go`
    * if empty, return empty
    * if the current position is already covered, skip it and continue with the rest of the field.
    * if this position doesn’t need protection, skip it and move one step right.
    * if the position needs protection, place the scarecrow and skip forward to the next uncovered position

```hs
placeScarecrows :: [Int] -> Int -> [Int]
placeScarecrows field k = go 0 indexed
  where
    n = length field
    half = k `div` 2
    indexed = zip [0..] field

    go _ [] = []
    go i xs@((j, val):rest)
      | j < i = go i rest
      | val == 0 = go (j + 1) rest
      | otherwise =
          let place = min (n - 1) (j + half)
              right = min (n - 1) (place + half)
          in place : go (right + 1) rest
```

Let's test it with the given examples:

```sh
$ runhaskell scarecrows.hs "1 1 0 1 1 0 1" 3
Scarecrows: [1,4,6]
$ runhaskell scarecrows.hs "1 0 1 1 0 1" 3
Scarecrows: [1,4]
$ runhaskell scarecrows.hs "1 1 1 1 1" 1
Scarecrows: [0,1,2,3,4]
```

All OK!

### Compiling to an Executable

Let's compile to an executable:

```sh
$ ghc scarecrows.hs
[1 of 2] Compiling Main             ( scarecrows.hs, scarecrows.o ) [Missing object file]
[2 of 2] Linking scarecrows
```

Can now use the executable `scarecrows`:

```sh
$ ./scarecrows "0 1 0 1 1 0" 3
Scarecrows: [2,5]
```

### Example Code

Final code is in [scarecrows.hs](./scarecrows.hs):

```hs
import System.Environment (getArgs)

-- solver
placeScarecrows :: [Int] -> Int -> [Int]
placeScarecrows field k = go 0 indexed
  where
    n = length field
    half = k `div` 2
    indexed = zip [0..] field

    go _ [] = []
    go i xs@((j, val):rest)
      | j < i = go i rest
      | val == 0 = go (j + 1) rest
      | otherwise =
          let place = min (n - 1) (j + half)
              right = min (n - 1) (place + half)
          in place : go (right + 1) rest

-- main program
main :: IO ()
main = do
    args <- getArgs
    case args of
      [fieldStr, kStr] -> do
          let field = map read (words fieldStr) :: [Int]
              k = read kStr :: Int
              result = placeScarecrows field k
          putStrLn $ "Scarecrows: " ++ show result
      _ -> putStrLn "Usage: runhaskell scarecrows.hs \"0 1 0 1 1 0\" 3"
```

## Credits and References

* [cassidoo's interview question of the week (2025-10-27)](https://buttondown.com/cassidoo/archive/with-the-new-day-comes-new-strength-and-new/)
