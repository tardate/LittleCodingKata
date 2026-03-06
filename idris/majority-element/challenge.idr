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
