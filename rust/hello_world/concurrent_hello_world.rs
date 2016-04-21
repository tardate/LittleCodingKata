use std::time::Duration;
use std::thread::sleep;
use std::thread;


// This function creates ten threads that all execute concurrently.
// To verify this, run the program several times and observe the irregular
// order in which each thread's output is printed.
fn main() {

    // This string is immutable, so it can safely be accessed from multiple threads.
    let greeting = "Hello";

    let mut threads = Vec::new();

    // `for` loops work with any type that implements the `Iterator` trait.
    for num in 0..10 {

        threads.push(thread::spawn(move || {
            // `println!` is a macro that statically typechecks a format string.
            // Macros are structural (as in Scheme) rather than textual (as in C).
            println!("{} from thread number {}", greeting, num);
            sleep(Duration::from_millis(300));
            println!("Goodbye from thread number {}", num);
        }));

    }

    // Join each thread so that they all finish before program exit.
    for thread in threads {
        thread.join().unwrap();
    }

}
