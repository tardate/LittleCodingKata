use std::env;
use hyperfactorial;


fn main() {
    let args: Vec<String> = env::args().collect();
    if args.len() < 2 {
        eprintln!("Usage: {} <number>", args[0]);
        std::process::exit(1);
    }
    let number: u32 = args[1].parse().unwrap_or_else(|_| {
        eprintln!("Error: '{}' is not a valid integer", args[1]);
        std::process::exit(1);
    });

    let result = hyperfactorial::hyperfactorial(number);
    println!("{}", result);
}
