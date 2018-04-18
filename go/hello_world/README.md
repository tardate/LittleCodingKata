# Hello World! in Go

exploring Go with the simplest example


[:arrow_forward: return to the Catalog](https://codingkata.tardate.com)

## Notes

This simple example demonstrates a few Go features:

* package names. Executable commands must always use package main.
* placing packages in unique import paths (`lck/hello`, `lck/stringthings`)
* conventional project structure: src, pkg, bin folders
* compile and build without makefiles (`go install ..`)
* conventions for unit testing

### Running the Example

Set the `GOPATH` to the folder containing the `src`. Here I'm running from the folder itself:

```
$ export GOPATH=$(pwd)
```

Run the tests:

```
$ go test lck/stringthings
ok    lck/stringthings  0.006s
```

Compile and run the executable it produces in the `bin` folder:

```
$ go install lck/hello
$ bin/hello
Hola Mundo
odnuM aloH
```

## Credits and References
* [How to Write Go Code](https://golang.org/doc/code.html)
* [naming conventions](https://golang.org/doc/effective_go.html#names) - Effective Go
