use std::io;
use std::env;
use gaffer;

use failure::ResultExt;
use exitfailure::ExitFailure;

fn main() -> Result<(), ExitFailure> {
    let args: Vec<String> = env::args().collect();
    let max_duration: i32 = args.iter()
        .position(|arg| arg == "-m")
        .and_then(|pos| args.get(pos + 1))
        .and_then(|val| val.parse().ok())
        .unwrap_or(60);
    println!("Max duration is set to {}", max_duration);

    println!("Enter the comma-separated list of song durations:");
    let mut input = String::new();
    io::stdin().read_line(&mut input)
        .with_context(|_| "Failed to read from stdin")?;
    let durations: Vec<i32> = input
        .trim()
        .split(',')
        .filter_map(|s| s.trim().parse().ok())
        .collect();
    println!("Song durations: {:?}", durations);

    let result = gaffer::ffd(durations, max_duration);
    println!("Playlists (by FDD): {:?}", result);
    Ok(())
}
