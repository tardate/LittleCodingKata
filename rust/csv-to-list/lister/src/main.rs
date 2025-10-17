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
