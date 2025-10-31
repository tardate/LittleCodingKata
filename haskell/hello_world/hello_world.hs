import System.Environment

main :: IO ()
main = getArgs >>= parse

parse [name] = hello name
parse [] = hello_world

hello_world = putStrLn "Hello World"
hello name = putStrLn $ "Hello " ++ name
