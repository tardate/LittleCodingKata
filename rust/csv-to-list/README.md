# #372 csvToList

Using rust to format CSV data for printing; cassidoo's interview question of the week (2025-10-13).
I test two common approaches for deserializing CSV in rust, and consider factoring of console IO for testability.

## Notes

The [interview question of the week (2025-10-13)](https://buttondown.com/cassidoo/archive/the-best-relationships-develop-out-of-friendships/)
presents a conventional CSV manipulation problem:

> Given a CSV string where each row contains a name, age, and city (and values may be quoted, have embedded commas or escaped quotes), write a function that parses the CSV and outputs a formatted list of strings in the form: "Name, age Age, from City". Handle quoted fields containing commas and escaped quotes.
>
> Example:
>
> ```ts
> const csv = 'name,age,city\n"Ryu, Mi-yeong",30,"Seoul"\nZoey,24,"Burbank"'
>
> csvToList(csv)
> > `
> - Ryu, Mi-yeong, age 30, from Seoul
> - Zoey, age 24, from Burbank
> `
> ```

### Thinking about the Problem

The main challenge is parsing the CSV format. These are conventional CSV rules.
Rather than attempt to write a CSV parser from scratch, I think I'll use this as an opportunity to test Rust's CSV support.

### Key CSV Parsing Options in Rust

#### 1\. The `csv` Crate

This is the de-facto standard for CSV handling in Rust is the [`csv`](https://crates.io/crates/csv) crate
It provides robust and performant reading and writing capabilities.

* **Low-Level Record Reading:** You can read CSV data into weakly-typed representations:
    * **`StringRecord`**: Used when you expect your data to be valid **UTF-8**.
    * **`ByteRecord`**: Used for reading data that may contain invalid UTF-8 (byte-oriented).
* **High-Level Serde Deserialization:** For strongly-typed data, you can leverage [`serde`](https://crates.io/crates/serde) (with the `derive` feature) to automatically deserialize CSV records into custom Rust structs or tuples:

    ```rust
    #[derive(Debug, serde::Deserialize)]
    struct Record {
        year: u16,
        make: String,
        model: String,
    }
    // rdr.deserialize::<Record>() will yield an iterator of Result<Record, csv::Error>
    ```

* **Customization:** The `ReaderBuilder` allows for extensive configuration, including:
    * Setting a **different delimiter** (e.g., semicolon `;` for TSV or region-specific CSVs).
    * Specifying a **quote character** and **quote style**.
    * Disabling/Enabling the **header record**.
    * Enabling **flexible parsing** to handle records with unequal numbers of fields.
    * Handling different **line endings** (`\n` or `\r\n`).
    * Custom error handling for invalid data within fields (e.g., automatically converting invalid data to `None` values via `csv::invalid_option`).

#### 2\. Dataframe Libraries

For heavier data processing, data analysis, and large files, libraries that manage data in a columnar format (Struct of Vectors/SoA) are often preferred for performance.

* [`polars`](https://crates.io/crates/polars): This is a high-performance dataframe library written in Rust. It includes robust CSV parsing capabilities optimized for speed and memory efficiency.
    * **Columnar Storage:** Stores data by column, which can be faster for certain operations like aggregation.
    * **Read Options:** Libraries like `polars` often provide extensive reading options such as multi-threading, schema specification, column selection, date parsing, handling null values, and truncation of ragged lines.

### Initial Solution

I'll start with just the [`csv`](https://crates.io/crates/csv) crate.

Creating the app framework with `cargo`:

```sh
$ cargo new lister
...
$ cd lister/
$ cargo add csv
$ cargo run
...
Hello, world!
```

A simple implementation:

```rust
pub fn csv_to_list_default(filename: String) {
    let mut rdr = csv::Reader::from_path(filename).expect("Cannot open file");
    println!("`");
    for result in rdr.records() {
        let record = result.expect("Error reading record");
        println!("- {}, age {}, from {}", record.get(0).unwrap_or(""), record.get(1).unwrap_or(""), record.get(2).unwrap_or(""));
    }
    println!("`");
}
```

It works as expected with the example data:

```sh
$ cargo run -- ../data_eg1.csv
    Finished `dev` profile [unoptimized + debuginfo] target(s) in 0.00s
     Running `target/debug/lister ../data_eg1.csv`
`
- Ryu, Mi-yeong, age 30, from Seoul
- Zoey, age 24, from Burbank
`
```

But a couple of things are not so nice about this implementation:

* the embedded `println!` calls make it tough to write automated tests
* we're having to guard every field access e.g. `record.get(0).unwrap_or("")`

### Refactoring for Testability

By allowing the function to accept a generic `std::io::Write` implementation,
we can provided a buffer for testing purposes, or fallback on `stdout` for normal use.

```rust
use std::io::{self, Write};
pub fn csv_to_list_default(filename: String, writer: Option<&mut dyn Write>) -> io::Result<()>  {
    let mut default_writer;
    let selected_writer: &mut dyn Write = match writer {
        Some(w) => w,
        None => {
            default_writer = io::stdout();
            &mut default_writer
        }
    };
    let mut rdr = csv::Reader::from_path(filename).expect("Cannot open file");
    writeln!(selected_writer, "`")?;
    for result in rdr.records() {
        let record = result.expect("Error reading record");
        writeln!(selected_writer, "- {}, age {}, from {}", record.get(0).unwrap_or(""), record.get(1).unwrap_or(""), record.get(2).unwrap_or(""))?;
    }
    writeln!(selected_writer, "`")?;
    Ok(())
}
```

The function still works as expected, but now we can more easily write tests.

### Using serde

Adding serde with derive features
`cargo add serde --features derive`,
can now define the expected record structure and iterate records with typed field access:

```rust
#[derive(Debug, Deserialize)]
struct PersonRecord {
    name: String,
    age: u8,
    city: String,
}
...
    for result in rdr.deserialize::<PersonRecord>() {
        let record = result.expect("Error reading record");
        writeln!(selected_writer, "- {}, age {}, from {}", record.name, record.age, record.city).expect("Error writing record");
    }
...
```

It works as expected with the example data and the "serde" algorithm selected:

```sh
$ cargo run -- ../data_eg1.csv -a serde
    Finished `dev` profile [unoptimized + debuginfo] target(s) in 0.01s
     Running `target/debug/lister ../data_eg1.csv -a serde`
`
- Ryu, Mi-yeong, age 30, from Seoul
- Zoey, age 24, from Burbank
`
```

### Tests

I've added some basic unit tests for the main algorithm functions:

```sh
$ cargo test
    Finished `test` profile [unoptimized + debuginfo] target(s) in 0.04s
     Running unittests src/lib.rs (target/debug/deps/lister-dccf3f2045326c28)

running 2 tests
test tests::test_csv_to_list_default ... ok
test tests::test_csv_to_list_serde ... ok

test result: ok. 2 passed; 0 failed; 0 ignored; 0 measured; 0 filtered out; finished in 0.00s

     Running unittests src/main.rs (target/debug/deps/lister-2ef4a6e6eafbbad5)

running 0 tests

test result: ok. 0 passed; 0 failed; 0 ignored; 0 measured; 0 filtered out; finished in 0.00s

   Doc-tests lister

running 0 tests

test result: ok. 0 passed; 0 failed; 0 ignored; 0 measured; 0 filtered out; finished in 0.00s
```

### Example Code

Final code comprises:

* [lister/src/main.rs](./lister/src/main.rs) - handles command-line invocation and option parsing
* [lister/src/lib.rs](./lister/src/lib.rs) - implements the actual algorithms

[main.rs](./lister/src/main.rs):

```rust
use std::env;
use lister;

fn main() -> Result<(), Box<dyn std::error::Error>> {
    let args: Vec<String> = env::args().collect();
    if args.len() < 2 {
        eprintln!("Usage: {} <csv-file> [-a <algorithm: default, serde>]", args[0]);
        std::process::exit(1);
    }
    let filename: String = args[1].parse().unwrap_or_else(|_| {
        eprintln!("Error: '{}' is not a valid string", args[1]);
        std::process::exit(1);
    });

    let algorithm: String = args.iter()
        .position(|arg| arg == "-a")
        .and_then(|pos| args.get(pos + 1))
        .cloned()
        .unwrap_or_else(|| "default".into());

    if algorithm == "serde" {
        Ok(lister::csv_to_list_serde(filename, None)?)
    } else {
        Ok(lister::csv_to_list_default(filename, None)?)
    }
}
```

[lib.rs](./lister/src/lib.rs):

```rust
use std::io::{self, Write};
use serde::Deserialize;

pub fn csv_to_list_default(filename: String, writer: Option<&mut dyn Write>) -> io::Result<()>  {
    let mut default_writer;
    let selected_writer: &mut dyn Write = match writer {
        Some(w) => w,
        None => {
            default_writer = io::stdout();
            &mut default_writer
        }
    };
    let mut rdr = csv::Reader::from_path(filename).expect("Cannot open file");
    writeln!(selected_writer, "`")?;
    for result in rdr.records() {
        let record = result.expect("Error reading record");
        writeln!(selected_writer, "- {}, age {}, from {}", record.get(0).unwrap_or(""), record.get(1).unwrap_or(""), record.get(2).unwrap_or(""))?;
    }
    writeln!(selected_writer, "`")?;
    Ok(())
}

#[derive(Debug, Deserialize)]
struct PersonRecord {
    name: String,
    age: u8,
    city: String,
}

pub fn csv_to_list_serde(filename: String, writer: Option<&mut dyn Write>) -> io::Result<()>  {
    let mut default_writer;
    let selected_writer: &mut dyn Write = match writer {
        Some(w) => w,
        None => {
            default_writer = io::stdout();
            &mut default_writer
        }
    };
    let mut rdr = csv::Reader::from_path(filename).expect("Cannot open file");
    writeln!(selected_writer, "`")?;
    for result in rdr.deserialize::<PersonRecord>() {
        let record = result.expect("Error reading record");
        writeln!(selected_writer, "- {}, age {}, from {}", record.name, record.age, record.city).expect("Error writing record");
    }
    writeln!(selected_writer, "`")?;
    Ok(())
}

#[cfg(test)]
mod tests {
    use super::*;
    use std::io::Cursor;
    use std::str;

    #[test]
    fn test_csv_to_list_default() {
        let mut buffer = Cursor::new(Vec::new());
        let result = csv_to_list_default("../data_eg1.csv".to_string(), Some(&mut buffer));

        assert!(result.is_ok());
        let output_bytes = buffer.into_inner();
        let captured_output = str::from_utf8(&output_bytes).expect("Output was not valid UTF-8");
        let captured_lines: Vec<&str> = captured_output.trim().lines().collect();
        assert_eq!(captured_lines.len(), 4);
        assert_eq!(captured_lines[0], "`");
        assert_eq!(captured_lines[1], "- Ryu, Mi-yeong, age 30, from Seoul");
        assert_eq!(captured_lines[2], "- Zoey, age 24, from Burbank");
        assert_eq!(captured_lines[3], "`");
    }

    #[test]
    fn test_csv_to_list_serde() {
        let mut buffer = Cursor::new(Vec::new());
        let result = csv_to_list_serde("../data_eg1.csv".to_string(), Some(&mut buffer));

        assert!(result.is_ok());
        let output_bytes = buffer.into_inner();
        let captured_output = str::from_utf8(&output_bytes).expect("Output was not valid UTF-8");
        let expected_output = "`\n- Ryu, Mi-yeong, age 30, from Seoul\n- Zoey, age 24, from Burbank\n`\n";
        assert_eq!(captured_output, expected_output);
    }
}
```

## Credits and References

* [cassidoo's interview question of the week (2025-10-13)](https://buttondown.com/cassidoo/archive/the-best-relationships-develop-out-of-friendships/)
* <https://crates.io/crates/csv>
* <https://crates.io/crates/serde>
* <https://crates.io/crates/polars>
