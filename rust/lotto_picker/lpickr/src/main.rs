use std::env;
use itertools::Itertools;
use lpickr;

fn main() {
    let args: Vec<String> = env::args().collect();
    if args.len() == 3 {
        let number_count: usize = args[1].parse().unwrap();
        let upper_limit: usize = args[2].parse().unwrap();
        println!("{}", lpickr::pick(number_count, upper_limit).iter().sorted().format(", "));
    } else {
        println!("Usage: lpickr <number_to_pick> <max>");
    }
}
