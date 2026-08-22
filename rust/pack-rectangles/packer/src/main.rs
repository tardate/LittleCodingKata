use std::env;
use packer;

fn arg_as_usize(arg: &str) -> usize {
    arg.parse().unwrap_or_else(|_| {
        eprintln!("Error: '{}' is not a valid integer", arg);
        std::process::exit(1);
    })
}

fn main() {
    let args: Vec<String> = env::args().collect();
    if args.len() != 5 {
        eprintln!("Usage: {} <n> <m> <a> <b>", args[0]);
        std::process::exit(1);
    }
    let n: usize = arg_as_usize(&args[1]);
    let m: usize = arg_as_usize(&args[2]);
    let a: usize = arg_as_usize(&args[3]);
    let b: usize = arg_as_usize(&args[4]);

    let result = packer::pack_rectangles(n, m, a, b);
    println!("{}", result);
}
