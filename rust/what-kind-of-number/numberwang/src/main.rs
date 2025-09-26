use std::env;
use numberwang;


fn main() {
    let args: Vec<String> = env::args().collect();
    if args.len() < 2 {
        eprintln!("Usage: {} <number> [-a <algorithm: naive, fast>]", args[0]);
        std::process::exit(1);
    }
    let number: u64 = args[1].parse().unwrap_or_else(|_| {
        eprintln!("Error: '{}' is not a valid integer", args[1]);
        std::process::exit(1);
    });

    let algorithm: String = args.iter()
        .position(|arg| arg == "-a")
        .and_then(|pos| args.get(pos + 1))
        .cloned()
        .unwrap_or_else(|| "naive".into());

    let classification = numberwang::what_kind_of_number(number, &algorithm);
    println!("{}", classification);
}
