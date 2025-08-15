# #005 Hello World in Rust

So the simplest "hello world" in rust is very C-like:

```rust
fn main() {
    println!("Hello, world!");
}
```

and runs as expected:

```sh
$ rustc hello_world.rs
$ ./hello_world
Hello, world!
```

But that doesn't show off much that's special.

## Concurrent Programming

So we could get a bit clever and use the
[std::thread](https://doc.rust-lang.org/std/thread/)
library to create a concurrent hello world.

Believe it or not, this example actually comes from the
[Rust wikipedia](https://en.wikipedia.org/wiki/Rust_(programming_language))
page, with modifications.

```sh
$ rustc concurrent_hello_world.rs
$ ./concurrent_hello_world
Hello from thread number 0
Hello from thread number 1
Hello from thread number 2
Hello from thread number 3
Hello from thread number 4
Hello from thread number 5
Hello from thread number 6
Hello from thread number 7
Hello from thread number 8
Hello from thread number 9
Goodbye from thread number 1
Goodbye from thread number 5
Goodbye from thread number 0
Goodbye from thread number 4
Goodbye from thread number 3
Goodbye from thread number 6
Goodbye from thread number 2
Goodbye from thread number 7
Goodbye from thread number 8
Goodbye from thread number 9
```

## Credits and References

* [Rust](https://en.wikipedia.org/wiki/Rust_(programming_language)) - wikipedia
* [std::thread](https://doc.rust-lang.org/std/thread/) library doc
