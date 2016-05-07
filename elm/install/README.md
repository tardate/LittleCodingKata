# Installing elm

## Notes

Perhaps one day elm will come with your browser, but for now
there are basically three methods for installing elm:

* binary distributions - Mac and Windows
* nms package
* build from source

I'll try my first tests using npm.

### Installing with npm

For routing use, [it is recommended to install elm globally](https://www.npmjs.com/package/elm):

    $ npm install -g elm

For a first test though, I'm going to install locally - even though elm does warn not to!

#### Initial package.json setup

    $ npm init
    $ npm install elm --save-dev

#### Install from package.json

    $ npm install

Pu tthe local node_packages bin directory on the path. Hopefully this should get around
any problems with this not being a global install:

    $ export PATH=$(npm bin):$PATH

So far so good:

```
$ elm
Elm Platform 0.16.0 - a way to run all Elm tools

Usage: elm <command> [<args>]

Available commands include:

  make      Compile an Elm file or project into JS or HTML
  package   Manage packages from <http://package.elm-lang.org>
  reactor   Develop with compile-on-refresh and time-travel debugging
  repl      A REPL for running individual expressions

You can learn more about a specific command by running things like:

  elm make --help
  elm package --help
  elm <command> --help

In all these cases we are simply running 'elm-<command>' so if you create an
executable named 'elm-foobar' you will be able to run it as 'elm foobar' as
long as it appears on your PATH.
```

### Quick REPL Test

Elm has a REPL package for testing snippets interactively.

```
$ elm repl
---- elm repl 0.16.0 -----------------------------------------------------------
 :help for help, :exit to exit, more at <https://github.com/elm-lang/elm-repl>
--------------------------------------------------------------------------------
> 1 + 1
2 : number
> f n = n + 1
<function> : number -> number
> f 41
42 : number
> :exit
```

### Going Global

OK, now that seems to be all working OK, I went ahead and installed globally:

    $ npm install -g elm


## Credits and References
* [Install](http://elm-lang.org/install) - elm site
* [npm elm package](https://www.npmjs.com/package/elm)
