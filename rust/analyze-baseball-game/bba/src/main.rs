use exitfailure::ExitFailure;
use failure::ResultExt;
use std::io;

use bba::analyze_baseball_game;

fn main() -> Result<(), ExitFailure> {
    println!("Enter the array of innings result arrays i.e. [[home, away]]:");
    let mut input = String::new();
    io::stdin().read_line(&mut input)
        .with_context(|_| "Failed to read from stdin")?;
    let innings: Vec<Vec<i32>> = serde_json::from_str(&input.trim())
        .with_context(|_| "Failed to parse innings as JSON array of integer pairs")?;
    println!("Given Innings: {:?}", innings);

    let result = analyze_baseball_game(&innings);
    println!("Result:\n{}", serde_json::to_string_pretty(&result).unwrap());

    Ok(())
}
