# #395 About Scala

An overview of the Scala programming language, its features, and ecosystem. Includes setting up and running on macOS.

## Notes

Scala features in Bruce Tate's [Seven Languages in Seven Weeks](../../books/seven-languages-in-seven-weeks/).

### Scala In a Nutshell

* **Scala is** a modern, statically typed programming language that runs on the JVM, designed to combine object-oriented and functional programming in a concise, expressive syntax.
* **Scala has** powerful language features such as type inference, immutability by default, pattern matching, higher-order functions, traits (for flexible composition), case classes, and seamless interoperability with Java and existing JVM libraries.
* **Scala has** a strong ecosystem, including build tools like **sbt**, popular frameworks and libraries such as **Akka**, **Play**, **Cats**, **ZIO**, and **Spark** (where Scala is the primary language), making it common in data engineering, distributed systems, and backend services.
* **Scala has** multiple runtime targets beyond the JVM, including **Scala.js** (JavaScript) and **Scala Native**, allowing shared code across server, browser, and native applications.
* **Scala is governed by** a combination of stewardship from **Lightbend** (the original creators), the **Scala Center** (which supports open-source development and education), and an open, community-driven language evolution process through **Scala Improvement Proposals (SIPs)**.
* **Scala has** an active global community of developers, researchers, and companies, with strong ties to academia and industry, and a culture that emphasizes functional programming principles, type safety, and scalable system design.

### Why Scala?

* **Expressiveness without losing performance**
  Scala lets you write very concise, high-level code (especially with functional patterns) while still compiling to fast JVM bytecode.
* **Best of OO and functional programming**
  You can model domains with objects *and* lean on functional techniques like immutability, pure functions, and algebraic data types—useful for complex, evolving systems.
* **Strong static typing that scales**
  Scala’s type system catches many errors at compile time without excessive verbosity, which pays off in large or long-lived codebases.
* **First-class JVM interoperability**
  You can use any Java library directly, migrate Java code incrementally, and deploy on mature JVM infrastructure (monitoring, profiling, cloud tooling).
* **Excellent for concurrency and distributed systems**
  Functional patterns plus libraries like **Akka**, **ZIO**, and **Cats Effect** make it easier to reason about concurrency, fault tolerance, and parallelism.
* **Industry standard for big data**
  **Apache Spark** is written in Scala and exposes its most natural API in Scala, making it a top choice for data engineering and analytics.
* **Multi-platform reach**
  With **Scala.js** and **Scala Native**, you can share core logic across backend, frontend, and native code.
* **Good fit for complex domains**
  When business rules, state transitions, or invariants are tricky, Scala’s pattern matching and type system help encode correctness directly in the code.
* **Active ecosystem and serious users**
  Backed by a strong open-source community and used in production by many tech and data-driven companies.

**In short:** use Scala when you want *Java-level performance and ecosystem* with *much stronger abstraction, correctness, and expressiveness*—especially for large, concurrent, or data-heavy systems.

### Seven Languages in Seven Weeks: Wrapping Up Scala

Core Strengths

* Concurrency
* Evolution of Legacy Java
* Domain-Specific Languages
* XML
* Bridging

Weaknesses

* Static Typing
* Syntax
* Mutability

## Test drive: Scala on macOS

To [install Scala](https://www.scala-lang.org/download/), it is recommended to use cs setup, the Scala installer powered by Coursier.
It ensures that a JVM and standard Scala tools are installed on your system.

I am running macOS on Apple Silicon,

```sh
$ brew install coursier && coursier setup
...
Found a JVM installed under /opt/homebrew/opt/openjdk/libexec/openjdk.jdk/Contents/Home.

Checking if ~/Library/Application Support/Coursier/bin is in PATH
  Should we add ~/Library/Application Support/Coursier/bin to your PATH via ~/.profile, ~/.bash_profile? [Y/n] Y

Checking if the standard Scala applications are installed
  Installed ammonite
  Installed cs
  Installed coursier
  Installed scala
  Installed scalac
  Installed scala-cli
  Installed sbt
  Installed sbtn
  Installed scalafmt
```

As I'm using a bash shell, I made sure the JDK and Coursier paths are set in `.bash_profile`:

```sh
export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"
export PATH="$PATH:/Users/paulgallagher/Library/Application Support/Coursier/bin"
```

In a fresh terminal window, let's verify the tools work.

| Commands | Description |
|----------|--------------|
| `scalac` | the Scala compiler |
| `scala`, `scala-cli` | Scala CLI, interactive toolkit for Scala |
| `sbt`, `sbtn`  | The sbt build tool |
| `amm` | Ammonite is an enhanced REPL |
| `scalafmt` | Scalafmt is the Scala code formatter |

OK, some unexpected warnings e.g.

```sh
$ scalac --version
WARNING: A terminally deprecated method in sun.misc.Unsafe has been called
WARNING: sun.misc.Unsafe::objectFieldOffset has been called by scala.runtime.LazyVals$ (file:/Users/paulgallagher/Library/Caches/Coursier/v1/https/repo1.maven.org/maven2/org/scala-lang/scala3-library_3/3.7.4/scala3-library_3-3.7.4.jar)
WARNING: Please consider reporting this to the maintainers of class scala.runtime.LazyVals$
WARNING: sun.misc.Unsafe::objectFieldOffset will be removed in a future release
Scala compiler version 3.7.4 -- Copyright 2002-2025, LAMP/EPFL
```

Apparently:

* it's a JDK warning, not a Scala bug.
* Scala 3.7.4 uses sun.misc.Unsafe internally for lazy val.
* New Java versions now warn loudly about it.
* It’s safe for now, expected, and already on the Scala roadmap.

Ignoring the warnings:

```sh
$ scalac --version
Scala compiler version 3.7.4 -- Copyright 2002-2025, LAMP/EPFL
$ scala --version
Scala code runner version: 1.9.1
Scala version (default): 3.7.4
$ scala-cli --version
Scala CLI version: 1.11.0
Scala version (default): 3.7.4
$ amm --version
Ammonite REPL & Script-Runner, 3.0.6
$ scalafmt --version
scalafmt 3.10.3

```

### Hello World

Following the [Getting Started Guide](https://docs.scala-lang.org/getting-started/install-scala.html)..

The most basic scale program in [hello.scala](./hello.scala)

```scala
//> using scala 3.7.4

@main
def hello(): Unit =
  println("Hello, World!")
```

Running it directly for the first time, scala downloaded the JVM and compilation server and compiled the program:

```sh
$ scala run hello.scala

Downloading JVM temurin:17
Downloading compilation server 2.0.13
Starting compilation server
Compiling project (Scala 3.7.4, JVM (17))
Compiled project (Scala 3.7.4, JVM (17))
Hello, World!
```

Re-running:

```sh
$ scala run hello.scala
Hello, World!
```

## Credits and References

* <https://www.scala-lang.org/>
* <https://www.scala-js.org/>
* [Seven Languages in Seven Weeks](../../books/seven-languages-in-seven-weeks/) - Chapter 5: Scala
