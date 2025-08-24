use laundry::create_laundry_item;

fn main() {
    let mut towel = create_laundry_item();

    println!("{}", towel.next_cycle());
    println!("{}", towel.next_cycle());
    println!("{}", towel.next_cycle());
    println!("{}", towel.next_cycle());
    println!("{}", towel.next_cycle());
    println!("{}", towel.next_cycle());
    println!("{}", towel.next_cycle());
}
