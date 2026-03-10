# #426 About miniKanren

An overview of the miniKanren logic programming language, its features, and ecosystem. Includes setting up and running miniKanren embedded in Clojure on macOS.

## Notes

miniKanren features in Bruce Tate's [Seven More Languages in Seven Weeks](../../books/seven-more-languages-in-seven-weeks/).

The name kanren comes from a Japanese word (関連) meaning "relation".

### miniKanren In a Nutshell

miniKanren is..

* a family of Domain Specific Languages for logic programming.
* a minimal, educationally oriented logic language whose complete core implementation fits on only a few pages of code.
* designed to be easily modified and extended; extensions include Constraint Logic Programming, probabilistic logic programming, nominal logic programming, and tabling.
* typically implemented as a small embedded DSL inside a host language, most commonly Scheme but also many others.
* designed to support relational programming, where relationships between values are described declaratively and can be executed in multiple directions (inputs or outputs).
* part of the broader tradition of logic programming (related to languages like Prolog) but intentionally simpler and more compositional.

miniKanren has..

* a tiny logical core consisting primarily of:
    * unification (`==`)
    * conjunction (logical AND of goals)
    * disjunction (logical OR / choice points)
    * introduction of fresh logic variables.
* bidirectional execution, allowing queries to run “forward” or “backward” (e.g., find inputs that produce a given result).
* a complete interleaving search strategy that alternates across branches to avoid some infinite-loop behaviours typical in depth-first logic languages.
* logic variables and unification, enabling symbolic reasoning and constraint solving.
* optional constraint systems (e.g., disequality, type constraints) in many implementations.
* numerous extensions and variants, including constraint logic programming, nominal logic, probabilistic reasoning, and tabling.
* implementations in a growing number of host languages, including Scheme, Racket, Clojure, Haskell, Python, JavaScript, Scala, Ruby, OCaml, and PHP, among many other languages.
* teaching and research materials such as the book [The Reasoned Schemer](../../books/the-reasoned-schemer/), which popularized the language and its relational programming techniques.
* an active but relatively small ecosystem of workshops, research papers, and experimental implementations.

miniKanren is governed by..

* a philosophy of minimalism and composability, keeping the core language extremely small and easy to understand or extend.
* an academic and research-driven community, with strong roots in programming-language research and education.
* a culture of portable embeddings, encouraging implementations inside many host languages.

### Seven More Languages in Seven Weeks: Wrapping Up miniKanren

Strengths

* declarative programming makes it easy to express problems such as constraint solving,
scheduling, and path finding.
* Core.logic adds to this mix the integration with a practical, everyday program-
ming language, Clojure, along with the entire Java ecosystem.

Weaknesses

* Logic programming is mind-bending. When it goes wrong, it is hard to tell
why

### Test drive: miniKanren embedded in Clojure on macOS

One of the easiest ways to get started is with
[core.logic](https://github.com/clojure/core.logic), an implementation
of miniKanren embedded in Clojure.

I already have Clojure installed - see [LCK#399 About Clojure](../../clojure/about/) for details, so I just need to include the core.logic dependency to get started.
See [deps.edn](./deps.edn):

```txt
{:deps
 {org.clojure/core.logic {:mvn/version "1.1.1"}}}
```

Now I can invoke the repl and start playing with miniKanren:

```sh
$ clj
Downloading: org/clojure/core.logic/1.1.1/core.logic-1.1.1.pom from central
Downloading: org/clojure/pom.contrib/1.4.0/pom.contrib-1.4.0.pom from central
Downloading: org/clojure/core.logic/1.1.1/core.logic-1.1.1.jar from central
Clojure 1.12.4
user=> (use 'clojure.core.logic)
WARNING: == already refers to: #'clojure.core/== in namespace: user, being replaced by: #'clojure.core.logic/==
nil
user=> (run* [q] (== q 1))
(1)
user=> (run 2 [q] (membero q [1 2 3]))
(1 2)
```

Setting up a database of facts:

```sh
user=> (use 'clojure.core.logic.pldb)
WARNING: indexed? already refers to: #'clojure.core/indexed? in namespace: user, being replaced by: #'clojure.core.logic.pldb/indexed?
nil
user=> (db-rel mano x)
#'user/mano
user=> (db-rel womano x)
#'user/womano
user=> (def facts
    (db
    [mano :alan-turing]
    [womano :grace-hopper]
    [mano :leslie-lamport]
    [mano :alonzo-church]
    [womano :ada-lovelace]
    [womano :barbara-liskov]
    [womano :frances-allen]
    [mano :john-mccarthy]))
#'user/facts
user=> (with-db facts (run* [q] (womano q)))
(:grace-hopper :frances-allen :barbara-liskov :ada-lovelace)
```

## Credits and References

* <https://minikanren.org/>
* <https://en.wikipedia.org/wiki/MiniKanren>
* [core.logic](https://github.com/clojure/core.logic) - miniKanren embedded in clojure
* [Seven More Languages in Seven Weeks](../../books/seven-more-languages-in-seven-weeks/) - Chapter 6: miniKanren
* [The Reasoned Schemer](../../books/the-reasoned-schemer/)
