# #xxx About Erlang

An overview of the Erlang programming language, its features, and ecosystem. Includes setting up and running on macOS.

## Notes

Erlang features in Bruce Tate's [Seven Languages in Seven Weeks](../../books/seven-languages-in-seven-weeks/).

### Erlang In a Nutshell

* **Erlang is…**

    * A **functional, concurrent programming language** designed for building **highly available, fault-tolerant, distributed systems**.
    * Originally developed at **Ericsson** for telecom switches, where **99.999% uptime** was a hard requirement.
    * A language that follows the philosophy **“let it crash”**, relying on supervision rather than defensive coding.
    * Particularly well suited to **soft real-time systems** where low latency and continuous operation matter more than raw throughput.

* **Erlang has…**

    * **Lightweight processes** (not OS threads) that can scale to **millions of concurrent processes**.
    * **Message-passing concurrency** with no shared mutable state, avoiding locks and data races.
    * **Immutable data** and strong pattern matching for clear, declarative code.
    * **Hot code swapping**, allowing systems to be upgraded **without downtime**.
    * **Built-in distribution**, making it easy to run the same program across multiple nodes.
    * The **BEAM virtual machine**, optimized for concurrency, isolation, and fault tolerance.
    * **OTP (Open Telecom Platform)**: a mature set of frameworks and behaviours (e.g. `gen_server`, `supervisor`, `application`) that encode best practices.
    * A stable but conservative standard library, prioritising reliability over rapid change.

* **Erlang’s ecosystem includes…**

    * Widely used platforms and tools such as **RabbitMQ**, **CouchDB**, **Riak**, and parts of **WhatsApp**’s backend.
    * The **Hex package manager** and **Rebar3** build tool.
    * Close interoperability and shared tooling with **Elixir**, which also runs on the BEAM.
    * Strong suitability for **telecoms, messaging systems, distributed databases, and real-time backends**.

* **Erlang is governed by…**

    * The **Open Telecom Platform (OTP)** project, now maintained under the **Erlang/OTP open-source community**.
    * A **core team of maintainers**, with contributions from industry and academia.
    * A culture that values **stability, backwards compatibility, and correctness** over rapid feature churn.

* **Erlang’s community is…**

    * Relatively **small but highly experienced**, with many practitioners coming from large-scale production systems.
    * Strongly opinionated about **fault tolerance, supervision, and system design**.
    * Closely connected to the **Elixir community**, which has broadened the BEAM ecosystem and renewed interest in Erlang concepts.

### Seven Languages in Seven Weeks: Wrapping Up Erlang

Core Strengths

* Dynamic and Reliable
* Lightweight, Share-Nothing Processes
* OTP, the Enterprise Libraries
* Let It Crash

Core Weaknesses

* Syntax
* Integration

## Test drive: Erlang on macOS

I'm currently running macOS on Apple Silicon, and [Erlang is supported by Homebrew](https://formulae.brew.sh/formula/erlang).
Let's do that...

```sh
$ brew install erlang
...
$ erl -version
Erlang (SMP,ASYNC_THREADS) (BEAM) emulator version 16.1.2
```

### Hello World

Let's create a little hello service, see [hello_service.erl](./hello_service.erl):

```erlang
-module(hello_service).
-export([loop/0, hello/2]).
loop() ->
    receive
        {From, Msg} ->
            From ! ("Hi, " ++ Msg ++ "!"),
            loop()
end.

hello(To, Word) ->
    To ! {self(), Word},
    receive
        Hello -> Hello
    end.
```

Running it is a matter of:

* compiling
* spawning the process
* making a request to the service

```sh
$ erl
Erlang/OTP 28 [erts-16.1.2] [source] [64-bit] [smp:8:8] [ds:8:8:10] [async-threads:1] [jit] [dtrace]

Eshell V16.1.2 (press Ctrl+G to abort, type help(). for help)
1> c(hello_service).
{ok,hello_service}
2> Hello = spawn(fun hello_service:loop/0).
<0.91.0>
3> hello_service:hello(Hello, "Frank").
"Hi, Frank!"
4>
```

## Credits and References

* <https://www.erlang.org/>
* <https://formulae.brew.sh/formula/erlang>
* [Seven Languages in Seven Weeks](../../books/seven-languages-in-seven-weeks/) - Chapter 6: Erlang
