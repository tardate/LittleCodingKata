use std::env;
use challenge;

fn main() {
    let args: Vec<String> = env::args().collect();
    if args.len() != 3 {
        eprintln!("Usage: {} <yyyy> <mm>", args[0]);
        std::process::exit(1);
    }
    let yyyy: u32 = args[1].parse().unwrap_or_else(|_| {
        eprintln!("Error: '{}' is not a valid integer", args[1]);
        std::process::exit(1);
    });
    let mm: u32 = args[2].parse().unwrap_or_else(|_| {
        eprintln!("Error: '{}' is not a valid integer", args[2]);
        std::process::exit(1);
    });
    let result = challenge::get_sundays(yyyy, mm);
    println!("{:?}", result);
}
