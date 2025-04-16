extern crate structopt;
use structopt::StructOpt;

extern crate colored;
use colored::*;

extern crate failure;
use failure::ResultExt;

use exitfailure::ExitFailure;

#[derive(StructOpt)]
struct Options {
    #[structopt(default_value = "Meow!")]
    message: String,

    #[structopt(short = "d", long = "dead", help = "Make the cat appear dead")]
    dead: bool,

    #[structopt(short = "f", long = "file", parse(from_os_str))]
    catfile: Option<std::path::PathBuf>,

}

fn main() -> Result<(), ExitFailure> {
    let options = Options::from_args();

    let eye = if options.dead { "x" } else { "o" };

    let message = options.message;

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
