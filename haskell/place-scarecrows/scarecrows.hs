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
