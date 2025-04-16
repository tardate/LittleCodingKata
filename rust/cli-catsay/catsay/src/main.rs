extern crate structopt;
use structopt::StructOpt;

extern crate colored;
use colored::*;

use failure::ResultExt;
use exitfailure::ExitFailure;
use std::io::{self, Read};

#[derive(StructOpt)]
struct Options {
    #[structopt(default_value = "Meow!")]
    message: String,

    #[structopt(short = "d", long = "dead", help = "Make the cat appear dead")]
    dead: bool,

    #[structopt(short = "i", long = "stdin", help = "Read message from stdin")]
    stdin: bool,

    #[structopt(short = "f", long = "file", parse(from_os_str))]
    catfile: Option<std::path::PathBuf>,

}

fn main() -> Result<(), ExitFailure> {
    let options = Options::from_args();

    let eye = if options.dead { "x" } else { "o" };

    let mut message = String::new();
    if options.stdin {
        io::stdin().read_to_string(&mut message)
            .with_context(|_| "Failed to read from stdin")?;
        if message.ends_with('\n') {
            message.pop();
            if message.ends_with('\r') {
                message.pop();
            }
        }
    } else {
        message = options.message;
    }

    if message.to_lowercase() == "woof" {
        eprintln!("A cat shouldn't bark like a dog!");
    }

    match &options.catfile {
        Some(path) => {
            let cat_template = std::fs::read_to_string(path)
                .with_context(|_| format!("Could not read the file: {:?}", path))?;
            let cat_template = cat_template.replace("{message}", &message);
            let cat_template = cat_template.replace("{eye}", eye);
            println!("{}", &cat_template);
        }
        None => {
            println!("{}", message.bright_yellow().underline().on_purple());
            println!(" \\");
            println!("  \\");
            println!("    /\\_/\\");
            println!("   ( {eye} {eye} )", eye=eye.red().bold());
            println!("   =( I )=");
        }
    }
    Ok(())
}
