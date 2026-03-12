# #xxx About Julia

An overview of the Julia  programming language, its features, and ecosystem. Includes setting up and running on macOS.

## Notes

Julia is a high-level, high-performance dynamic language for technical computing.
Julia features in Bruce Tate's [Seven More Languages in Seven Weeks](../../books/seven-more-languages-in-seven-weeks/).

### Julia In a Nutshell

Julia is..

* A high-level, high-performance programming language designed for technical computing, especially numerical analysis, data science, and scientific simulation.
* A dynamically typed language with optional type annotations, allowing both rapid prototyping and highly optimized compiled code.
* A language that uses Just-In-Time (JIT) compilation via LLVM, enabling performance close to C/C++ while keeping a Python-like development experience.
* Designed to solve the "two-language problem", allowing the same language to be used for both research prototyping and production performance.
* Particularly popular in scientific computing, machine learning research, optimization, and quantitative finance.

Julia has..

* Multiple dispatch as its core programming paradigm, enabling elegant expression of mathematical and scientific abstractions.
* A rich type system with parametric types, abstract types, and user-defined types that compile efficiently.
* Metaprogramming capabilities (macros and code generation) inspired partly by Lisp-like languages.
* Built-in support for parallelism and distributed computing, including multithreading, GPU computing, and cluster execution.
* A package ecosystem centered on the Julia package manager (Pkg), enabling reproducible environments and dependency management.
* A growing ecosystem of domain libraries such as Flux.jl for machine learning and DifferentialEquations.jl for scientific modeling.
* Interoperability with languages such as Python, C, and Fortran, allowing reuse of existing scientific libraries.
* A notebook-style interactive workflow via Pluto.jl and integration with Jupyter Notebook.
* First-class support for linear algebra, array programming, and numerical methods in the standard library.

Julia is governed by..

* An open-source development model hosted primarily on GitHub.
* Core language development led by maintainers including Jeff Bezanson, Stefan Karpinski, Viral B. Shah, and Alan Edelman.
* Stewardship and community coordination by the JuliaLang community and related institutions.
* Commercial ecosystem support from JuliaHub, which provides tooling, cloud services, and enterprise support.
* A global community of researchers, developers, and data scientists collaborating through open-source packages, conferences, and the annual JuliaCon.

### Basic Syntax

Hello world

```julia
println("Hello, world")
```

Variables

```julia
x = 10
name = "Julia"
```

Function

```julia
function add(a, b)
    return a + b
end
```

Short form:

```julia
add(a, b) = a + b
```

Conditionals

```julia
if x > 0
    println("positive")
else
    println("non-positive")
end
```

Loops

```julia
for i in 1:5
    println(i)
end
```

Arrays

```julia
a = [1, 2, 3]
b = a .* 2      # element-wise multiply
```

Dictionary

```julia
d = Dict("a" => 1, "b" => 2)
```

Type definition

```julia
struct Point
    x::Float64
    y::Float64
end
```

Multiple dispatch example

```julia
area(r::Float64) = π * r^2
area(w::Float64, h::Float64) = w * h
```

### Seven More Languages in Seven Weeks: Wrapping Up Julia

Strengths

* excels at number crunching
* solid concurrency solution
* strong functional programming concepts
* built-in package system

Weaknesses

* it's a young language (publicly launched in 2012)
* lack of available packages, still growing

### Test drive: Julia on macOS

Packages for Julia for Windows, OS X, and Linux are available from <https://julialang.org/downloads/>,
or one can build from source.

There is also a [Homebrew formula](https://formulae.brew.sh/formula/julia), I'll use this for convenience:

```sh
$ brew install julia
...
$ julia --version
julia version 1.12.5
```

Using the repl:

```sh
$ julia
               _
   _       _ _(_)_     |  Documentation: https://docs.julialang.org
  (_)     | (_) (_)    |
   _ _   _| |_  __ _   |  Type "?" for help, "]?" for Pkg help.
  | | | | | | |/ _` |  |
  | | |_| | | | (_| |  |  Version 1.12.5 (2026-02-09)
 _/ |\__'_|_|_|\__'_|  |  Built by Homebrew (v1.12.5)
|__/                   |

julia> println("Hello, world!")
Hello, world!

julia> typeof(5)
Int64

julia> typeof(5.5)
Float64

julia> typeof(11//5)
Rational{Int64}
```

Julia has some best-in-class support for [bitwise operations](https://docs.julialang.org/en/v1/manual/mathematical-operations/#Bitwise-Operators).
The [bitstring](https://docs.julialang.org/en/v1/base/numbers/#Base.bitstring)
function returns the string giving the literal bit representation of a primitive type.

NB: The Julia bits function was renamed to bitstring around the time of the Julia 0.6 or 0.7 development cycle (prior to 1.0) to better reflect what the function actually does

```sh
julia> bitstring(5)
"0000000000000000000000000000000000000000000000000000000000000101"

julia> bitstring(6)
"0000000000000000000000000000000000000000000000000000000000000110"

julia> bitstring(6 & 5)
"0000000000000000000000000000000000000000000000000000000000000100"

julia> bitstring(6 | 5)
"0000000000000000000000000000000000000000000000000000000000000111"

julia> bitstring(~0)
"1111111111111111111111111111111111111111111111111111111111111111"
```

There are some unusual operator symbols (and more conventional function names) for
`xor`/`⊻`,
`nand`/`⊼`, and
`nor`/`⊽`
operations:

```sh
julia> bitstring(5 ⊻ 6)
"0000000000000000000000000000000000000000000000000000000000000011"

julia> bitstring(xor(5, 6))
"0000000000000000000000000000000000000000000000000000000000000011"

julia> bitstring(5 ⊼ 6)
"1111111111111111111111111111111111111111111111111111111111111011"

julia> bitstring(nand(5, 6))
"1111111111111111111111111111111111111111111111111111111111111011"

julia> bitstring(5 ⊽ 6)
"1111111111111111111111111111111111111111111111111111111111111000"

julia> bitstring(nor(5, 6))
"1111111111111111111111111111111111111111111111111111111111111000"
```

[Logical](https://en.wikipedia.org/wiki/Logical_shift) (`>>>`) and [arithmetic](https://en.wikipedia.org/wiki/Arithmetic_shift) (`>>`) right shift:

```sh
julia> bitstring(~8)
"1111111111111111111111111111111111111111111111111111111111110111"

julia> bitstring(~8 >>> 1)
"0111111111111111111111111111111111111111111111111111111111111011"

julia> bitstring(~8 >> 1)
"1111111111111111111111111111111111111111111111111111111111111011"
```

For left shift, there is no functional difference between logical and arithmetic shift, so just one one operator `<<`:

```sh
julia> bitstring(~8 << 1)
"1111111111111111111111111111111111111111111111111111111111101110"
```

Julia supports multiple dispatch, like C/C++:

```sh
julia> function concat(a :: Int64, b :: Int64)
  zeros = Int(ceil(log10(b+1)))
  a * 10^zeros + b
end
concat (generic function with 1 method)

julia> concat(117, 5)
1175

julia> concat(117, "5")
ERROR: MethodError: no method matching concat(::Int64, ::String)
The function `concat` exists, but no method is defined for this combination of argument types.

Closest candidates are:
  concat(::Int64, ::Int64)
   @ Main REPL[1]:1

Stacktrace:
 [1] top-level scope
   @ REPL[3]:1

julia> function concat(a :: Int64, b :: String)
  "$a$b"
end
concat (generic function with 2 methods)

julia> concat(117, "5")
"1175"

julia> concat(117, 5)
1175
```

### Example: A Coin-flip Histogram

Testing from the repl:

```sh
julia> using Distributed

julia> function pflip_coins(times)
    @distributed (+) for i = 1:times
        Int(rand(Bool))
    end
end
pflip_coins (generic function with 1 method)

julia> pflip_coins(10)
5

julia> function flip_coins_histogram(trials, times)
  bars = zeros(Int, times + 1)
  for i = 1:trials
    bars[pflip_coins(times) + 1] += 1
  end
  hist = pmap((len -> repeat("*", Int(len))), bars)
  for line in hist
    println("|$(line)")
  end
end
flip_coins_histogram (generic function with 1 method)

julia> flip_coins_histogram(100, 10)
|
|*
|*****
|***************
|************
|**************************
|***********************
|***********
|*****
|**
|
```

I've added a `main()` method in [coinflips.jl](./coinflips.jl)
so that it can be called from the command line:

```sh
$ julia coinflips.jl
Usage: julia coinflips.jl <trials> <times>
Mac:about paulgallagher$ julia coinflips.jl 100 10
|
|*
|******
|*******
|*****************
|******************************
|***********************
|**********
|******
|
|
```

See [coinflips.jl](./coinflips.jl):

```julia
using Distributed

function pflip_coins(times)
    @distributed (+) for i = 1:times
        Int(rand(Bool))
    end
end

function flip_coins_histogram(trials, times)
  bars = zeros(Int, times + 1)
  for i = 1:trials
    bars[pflip_coins(times) + 1] += 1
  end
  hist = pmap((len -> repeat("*", Int(len))), bars)
  for line in hist
    println("|$(line)")
  end
end

function main()
    if length(ARGS) != 2
        println("Usage: julia coinflips.jl <trials> <times>")
        exit(1)
    end

    trials = parse(Int, ARGS[1])
    times = parse(Int, ARGS[2])

    flip_coins_histogram(trials, times)
end

main()
```

## Credits and References

* <https://julialang.org/>
* <https://julialang.org/downloads/>
* <https://github.com/JuliaLang/julia>
* [Seven More Languages in Seven Weeks](../../books/seven-more-languages-in-seven-weeks/) - Chapter 5: Julia
