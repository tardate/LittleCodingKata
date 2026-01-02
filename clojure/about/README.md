# #399 About Clojure

An overview of the Clojure programming language, its features, and ecosystem. Includes setting up and running on macOS.

## Notes

Clojure features in Bruce Tate's [Seven Languages in Seven Weeks](../../books/seven-languages-in-seven-weeks/).

### Clojure In a Nutshell

Clojure is..

* a modern, functional, dynamically typed Lisp that runs primarily on the JVM (and also on JavaScript via **ClojureScript** and native via **GraalVM**), designed by Rich Hickey with a strong emphasis on simplicity and correctness.
* a hosted language, leveraging existing platforms (JVM, JS) for performance, libraries, and tooling rather than re-implementing them.
* expression-oriented and immutable by default, encouraging pure functions and data transformation over mutable state.
* a Lisp with a minimal, consistent syntax based on S-expressions, enabling powerful macros and code-as-data (homoiconicity).

Clojure has..

* persistent immutable data structures (lists, vectors, maps, sets) that are efficient and thread-safe.
* first-class support for concurrency via software transactional memory (STM), atoms, refs, agents, and immutable data.
* a strong emphasis on data over objects, using plain data structures and protocols instead of deep class hierarchies.
* powerful abstraction mechanisms such as higher-order functions, lazy sequences, transducers, multimethods, and protocols.
* a rich standard library focused on sequence processing and functional composition.
* seamless Java interoperability, allowing direct use of Java libraries and frameworks.
* a growing ecosystem including Leiningen and deps.edn for builds, REPL-driven development, and libraries like Ring, Compojure, Reitit, Pedestal, core.async, and Datomic.
* an active ClojureScript ecosystem for frontend and Node.js development, with tools like Re-frame, Shadow CLJS, and Figwheel.

Clojure is governed by..

* a conservative, stability-focused design philosophy led by its creator, Rich Hickey, with changes curated by a small core team.
* an emphasis on backward compatibility and long-term maintenance, resulting in slow but deliberate language evolution.
* a community that values pragmatism, REPL-centric workflows, and thoughtful design discussions over rapid feature churn.
* an open-source ecosystem, with most libraries community-maintained and strong norms around simplicity, composability, and documentation.

### Why Clojure?

* **It makes complex systems simpler**
  Clojure’s emphasis on immutable data, pure functions, and explicit state management reduces hidden coupling and makes large systems easier to reason about.
* **Concurrency without pain**
  Immutability plus STM, atoms, and agents let you write concurrent and parallel code with far fewer race conditions than mutable, lock-heavy approaches.
* **Excellent for data-centric problems**
  Clojure treats data as plain, ubiquitous structures (maps, vectors, sets), which fits naturally with APIs, JSON, databases, and event-driven systems.
* **Leverages the JVM ecosystem**
  You get access to mature JVM libraries, tooling, performance, and deployment infrastructure without sacrificing a functional programming model.
* **REPL-driven productivity**
  Interactive development via the REPL enables rapid feedback, exploratory programming, live debugging, and evolving systems without frequent restarts.
* **Powerful abstraction without heavy machinery**
  Higher-order functions, transducers, multimethods, and macros allow you to build expressive abstractions without complex class hierarchies.
* **Macros enable domain-specific expressiveness**
  Because Clojure is a Lisp, you can extend the language itself to better fit your problem domain—safely and deliberately.
* **Stability over churn**
  Clojure prioritizes backward compatibility and conservative evolution, making it well-suited for long-lived systems.
* **Functional without dogma**
  Clojure encourages functional programming but remains pragmatic: side effects are allowed, just made explicit and controlled.
* **Small language, big leverage**
  The core language is small, but composable primitives allow you to build powerful systems with fewer concepts to learn.
* **Strong community values**
  The community emphasizes clarity, thoughtful design, and maintainability over trends or hype.

In short: **use Clojure when correctness, concurrency, and long-term maintainability matter more than syntactic familiarity or rapid language churn.**

### Seven Languages in Seven Weeks: Wrapping Up Clojure

Core Strengths:

* A Good Lisp
* Concurrency
* Java Integration
* Lazy Evaluation
* Data as Code

Core Weaknesses

* Prefix Notation
* Readability
* Learning Curve
* Limited Lisp
* Accessibility

## Test drive: Clojure on macOS

NB: Seven Languages in Seven Weeks uses
[leiningen](https://github.com/technomancy/leiningen)
project management tool
to install and run Clojure, but I'll just used the basic tools for now...

I am running macOS on Apple Silicon, and happily
[a Homebrew keg](https://clojure.org/guides/install_clojure)
is available for installation:

```sh
$ brew install clojure/tools/clojure
...
==> Installing clojure/tools/clojure
==> ./install.sh /opt/homebrew/Cellar/clojure/1.12.4.1582
🍺  /opt/homebrew/Cellar/clojure/1.12.4.1582: 12 files, 17.4MB, built in 1 second
==> Running `brew cleanup clojure`...
```

Let's verify the CLI and REPL works:

```sh
$ clj --version
Clojure CLI version 1.12.4.1582
$ clj
Clojure 1.12.4
user=> (+ 2 3)
5
```

### Hello World

Following the ["Writing a program" Guide](https://clojure.org/guides/deps_and_cli#_writing_a_program)..

A simple program with 1 library dependency. See sources:

* [deps.edn](deps.edn)
* [src/hello.clj](src/hello.clj)

This program has an entry function `run` that can be executed by `clj` using `-X`:

```clojure
$ clj -X hello/run
Hello world, the time is 01:41 pm
```

## Credits and References

* <https://clojure.org/>
* <https://clojure.org/guides/getting_started>
* <https://github.com/technomancy/leiningen>
* [Seven Languages in Seven Weeks](../../books/seven-languages-in-seven-weeks/) - Chapter 7: Clojure
