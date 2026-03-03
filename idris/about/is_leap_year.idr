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
