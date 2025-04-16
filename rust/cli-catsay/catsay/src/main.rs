extern crate structopt;
use structopt::StructOpt;

extern crate colored;
use colored::*;

#[derive(StructOpt)]
struct Options {
    #[structopt(default_value = "Meow!")]
    message: String,

    #[structopt(short = "d", long = "dead", help = "Make the cat appear dead")]
    dead: bool,
}

fn main() {
    let options = Options::from_args();
    let eye = if options.dead { "x" } else { "o" };
    let message = options.message;

    if message.to_lowercase() == "woof" {
        eprintln!("A cat shouldn't bark like a dog!");
    }

    println!("{}", message.bright_yellow().underline().on_purple());
    println!(" \\");
    println!("  \\");
    println!("    /\\_/\\");
    println!("   ( {eye} {eye} )", eye=eye.red().bold());
    println!("   =( I )=");
}
