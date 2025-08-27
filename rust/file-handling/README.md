# #xxx Rust File Handling

Reviewing common file operations with rust

## Notes

### Create

Create a file with [`std::fs::File::create`](https://doc.rust-lang.org/std/fs/struct.File.html#method.create)

* Opens a file in write-only mode.
* Create a file if it does not exist, truncates it if it does.
* Alternatives:
    * [`create_buffered`](https://doc.rust-lang.org/std/fs/struct.File.html#method.create_buffered) Opens a file in write-only mode with buffering
    * [`create_new`](https://doc.rust-lang.org/std/fs/struct.File.html#method.create_new) Creates a new file in read-write mode; error if the file exists.

Example:

    use std::fs::File
    let mut file = File::create("name.txt").expect("failed");

Or using the ? operator:

    let mut file = File::create("name.txt")?;

### Write

Write to a file with [write_all](https://doc.rust-lang.org/std/io/trait.Write.html#method.write_all)

* Attempts to write an entire buffer into this writer.

Example:

    use std::io::Write;
    file.write_all("Hello".as_bytes()).expect("failed");
    // or
    file.write_all("Hello".as_bytes())?;

### Append

Open a file for append using [`OpenOptions`](https://doc.rust-lang.org/std/fs/struct.OpenOptions.html)

* A builder used to configure how a File is opened and what operations are permitted on the open file.
* The `File::open` and `File::create` methods are aliases for commonly used options using this builder.

Example:

    use std::fs::OpenOptions;
    let mut file = OpenOptions::new().append(true).open("name.txt").expect("failed");
    file.write_all(" world!\n".as_bytes()).expect("failed");
    // or
    let mut file = OpenOptions::new().append(true).open("name.txt")?;
    file.write_all(" world!\n".as_bytes())?;

### Read File

Read from a file with [`read_to_string`](https://doc.rust-lang.org/std/fs/fn.read_to_string.html)

Example:

    use std::io::Read;
    let mut file = std::fs::File::open("name.txt").unwrap();
    file.read_to_string(&mut contents).unwrap();
    // or
    let mut file = std::fs::File::open("name.txt")?;
    file.read_to_string(&mut contents)?;

### Delete File

Delete a file with [`remove_file`](https://doc.rust-lang.org/std/fs/fn.remove_file.html)

    use std::fs;
    fs::remove_file("name.txt").expect("failed");
    // or
    fs::remove_file("name.txt")?;

## Example Code

See [file-demo/src/main.rs](./file-demo/src/main.rs).

Run:

    $ cargo run
        Finished `dev` profile [unoptimized + debuginfo] target(s) in 0.00s
        Running `target/debug/file-demo`
    creating file: example.txt
    Appending to file: example.txt
    Reading from file: example.txt
    Hello World!
    Appended content to the file.

    Deleting file: example.txt

## Credits and References

* <https://doc.rust-lang.org/std/fs/struct.File.html>
