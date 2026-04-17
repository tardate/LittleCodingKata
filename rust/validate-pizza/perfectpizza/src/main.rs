use exitfailure::ExitFailure;
use failure::ResultExt;
use serde_json;

use perfectpizza::validate_pizza;

fn main() -> Result<(), ExitFailure> {
    let args: Vec<String> = std::env::args().collect();
    if args.len() != 3 {
        return Err(ExitFailure::from(
            failure::err_msg("Usage: perfectpizza <layers.json> <rules.json>")
        ));
    }

    let layers_str = std::fs::read_to_string(&args[1])
        .context(format!("Failed to read layers file: {}", args[1]))?;
    let layers: Vec<String> = serde_json::from_str(&layers_str)
        .context("Failed to parse layers JSON")?;
    let rules_str = std::fs::read_to_string(&args[2])
        .context(format!("Failed to read rules file: {}", args[2]))?;
    let rules: Vec<Vec<String>> = serde_json::from_str(&rules_str)
        .context("Failed to parse rules JSON")?;

    println!("Given layers : {:?}", layers);
    println!("And rules    : {:?}", rules);

    let result = validate_pizza(&layers, &rules);
    println!("Result: {}", result);

    Ok(())
}
