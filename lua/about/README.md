# #xxx About Lua

An overview of the Lua programming language, its features, and ecosystem. Includes setting up and running on macOS.

## Notes

Factor features in Bruce Tate's [Seven More Languages in Seven Weeks](../../books/seven-more-languages-in-seven-weeks/).

### Lua In a Nutshell

Lua is..

* a lightweight, high-level, multi-paradigm scripting language designed for embedding and performance.
* dynamically typed, garbage-collected, and implemented primarily in ANSI C.
* known for its small footprint (often under 1 MB) and ease of integration into C/C++ applications.
* widely used as an embedded scripting language in games, devices, and applications (e.g., World of Warcraft, Roblox, Garry's Mod).
* designed around a minimal core with powerful extension mechanisms rather than a large standard library.

Lua has..

* a simple, clean syntax with first-class functions and lexical scoping.
* a single powerful data structure: the table (used for arrays, dictionaries, objects, and modules).
* proper tail calls and coroutines for lightweight cooperative multitasking.
* metatables and metamethods, enabling operator overloading and prototype-based object-oriented patterns.
* straightforward C API bindings, making it easy to extend with native code.
* multiple implementations and variants, including LuaJIT (high-performance JIT compiler) and Luau (a gradually typed dialect used by Roblox).
* a package/module system and a growing ecosystem of third-party libraries via LuaRocks (the de facto package manager).
* an official reference manual and the well-regarded book Programming in Lua by its chief architect, Roberto Ierusalimschy.

Lua is governed by..

* a small core team at the Pontifical Catholic University of Rio de Janeiro (PUC-Rio), often referred to as the Lua team.
* a stable, conservative evolution philosophy emphasizing backward compatibility and minimalism.
* an open-source license (the permissive MIT License).
* an active global community of developers in gaming, embedded systems, networking (e.g., Nginx via OpenResty), and scripting domains.

### Seven More Languages in Seven Weeks: Wrapping Up Lua

Core Strengths:

* an approachable, portable language for stitching together software components
* source code is easy to read, runs quickly, and works on a huge variety of platforms
    * [LuaJIT](https://luajit.org/luajit.html) now provides faster performance and a friendlier C interface
* Lua is easy to drop into your project
    * can even sandbox the embedded interpreter

Core Weaknesses:

* few official libraries or support for common higher level-abstractions
    * see [luarocks](https://luarocks.org/) for community-developed modules
* requires a bit of creativity to do string handling efficiently
* requires effort to take advantage of multicore systems
* has a few Pascal-like quirks such as 1-based array indexing and  do/end notation

## Test drive: Lua on macOS

Lua is [distributed](https://www.lua.org/download.html) in source that compiles on any platform that has an ISO C compiler.
Binaries for selected platforms are also available. There is also a [homebrew formula](https://formulae.brew.sh/formula/lua).

Testing build form source:

```sh
$ curl -L -R -O https://www.lua.org/ftp/lua-5.5.0.tar.gz
$ tar zxf lua-5.5.0.tar.gz
$ cd lua-5.5.0
$ make all test
...
$ src/lua -v
Lua 5.5.0  Copyright (C) 1994-2025 Lua.org, PUC-Rio
```

But for the rest of the exercise, I'll use a version installed with homebrew.
NB: as of now, the [homebrew formula](https://formulae.brew.sh/formula/lua) has not been updated for the
Lua 5.5.0 released from 22 Dec 2025.

```sh
$ brew install lua
...
$ lua -v
Lua 5.4.8  Copyright (C) 1994-2025 Lua.org, PUC-Rio
```

### Testing the repl

```lua
$ lua
Lua 5.4.8  Copyright (C) 1994-2025 Lua.org, PUC-Rio
> function squared(num)
>>   return num ^ 2
>> end
>
> =squared(2)
4.0
>
```

### Example: Factorial in Lua

See [factorial.lua](./factorial.lua):

```lua
#!/usr/bin/env lua

function reduce(max, init, f)
   local result = init
   for i = 1, max do
      result = f(result, i)
   end
   return result
end

function factorial(n)
  return reduce(n, 1, function(previous, next)
    return previous * next
  end)
end

local arg = tonumber(arg[1])

if not arg then
  print("Usage: lua factorial.lua [number]")
  os.exit(1)
end

print(factorial(arg))
```

Running with some examples:

```sh
$ ./factorial.lua
Usage: lua factorial.lua [number]
$ ./factorial.lua 1
1
$ ./factorial.lua 2
2
$ ./factorial.lua 3
6
$ ./factorial.lua 4
24
$ ./factorial.lua 5
120
$ ./factorial.lua 12
479001600
```

## Credits and References

* <https://www.lua.org/>
* <https://formulae.brew.sh/formula/lua>
* <https://luarocks.org/> - package manager for Lua modules
* <https://luajit.org/luajit.html> - a Just-In-Time Compiler (JIT) for the Lua programming language
* [Seven More Languages in Seven Weeks](../../books/seven-more-languages-in-seven-weeks/) - Chapter 1: Lua
* Programming in Lua by Roberto Ierusalimschy
    * <https://www.lua.org/pil/>
    * <https://www.goodreads.com/book/show/1332383.Programming_in_Lua>
