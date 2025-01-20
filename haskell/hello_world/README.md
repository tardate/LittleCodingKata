# #008 Hello World! in Haskell


## Notes

Haskell is an advanced purely-functional programming language.
So no surprise [hello_world.hs](./hello_world.hs) looks a little different!

Even this simple "Hello World" exercises at least 3 interesting Haskell features:

```
main = getArgs >>= parse
```

The `>>=` monad sequencing operator with value passing causes the result of `getArgs`
(an array of arguments) to be passed to the next function, `parse`.


```
parse [name] = hello name
parse [] = hello_world
```

Two patterns are bound to the function `parse`, handle the case of either 0 or 1 parameters.
This effects flow control without the need for case or if statements.


```
hello name = putStrLn $ "Hello " ++ name
```

The `$` operator causes anything appearing after it to take precedence over anything that comes before.
As used here, it ensures that the string concatenation `++` - which is normally right-associative - is
executed before `putStrLn`

## Compiling and Running the Example..

```
$ ghc hello_world.hs
[1 of 1] Compiling Main             ( hello_world.hs, hello_world.o )
Linking hello_world ...
$ ./hello_world
Hello World
$ ./hello_world Paul
Hello Paul
```

## Credits and References
* [The Haskell Programming Language](https://wiki.haskell.org/Haskell) - main site
* [3.4 Operator Applications](https://www.haskell.org/onlinereport/haskell2010/haskellch3.html#x8-280003.4) - Haskell report
* [Haskell: difference between . (dot) and $ (dollar sign)](http://stackoverflow.com/questions/940382/haskell-difference-between-dot-and-dollar-sign) - SO
* [Haskell operator vs function precedence](http://stackoverflow.com/questions/3125395/haskell-operator-vs-function-precedence) - SO
