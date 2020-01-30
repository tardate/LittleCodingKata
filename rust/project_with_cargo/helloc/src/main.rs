use rand::prelude::*;

fn random_values() {
    let x: u8 = random();
    println!("Random unsigned 8-bit number: {}", x);

    let b: bool = random();
    println!("Random boolean: {}", b);
}

fn random_choices() {
    let mut rng = thread_rng();

    let arrows_iter = "➡⬈⬆⬉⬅⬋⬇⬊".chars();
    println!("Random choice of direction: {}", arrows_iter.choose(&mut rng).unwrap());
}

fn random_shuffles() {
    let mut rng = thread_rng();
    let mut numbers = [1, 2, 3, 4, 5];
    println!("Unshuffled numbers: {:?}", numbers);
    numbers.shuffle(&mut rng);
    println!("Shuffled: {:?}", numbers);
}

fn main() {
    println!("Using the rand crate");
    println!("--------------------");
    random_values();
    random_choices();
    random_shuffles();
}
