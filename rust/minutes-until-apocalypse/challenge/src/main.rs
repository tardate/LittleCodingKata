use anyhow::{Context, Result};
use serde_json;

use challenge::minutes_until_apocalypse;

fn main() -> Result<()> {
    let args: Vec<String> = std::env::args().collect();
    if args.len() != 2 {
        return Err(anyhow::anyhow!("Usage: challenge <grid.json>"));
    }

    let grid_str = std::fs::read_to_string(&args[1])
        .context(format!("Failed to read grid file: {}", args[1]))?;
    let grid: Vec<Vec<i32>> = serde_json::from_str(&grid_str)
        .context("Failed to parse grid JSON")?;
    eprintln!("# Given grid : {:?}", grid);

    let result = minutes_until_apocalypse(&grid);
    eprintln!("# Result:");
    println!("{}", result);

    Ok(())
}
