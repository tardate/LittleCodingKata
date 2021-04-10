use example;

fn main() {
    println!("Loops in Rust");
    println!("loop: first number in Fibonacci sequence over 10 = {}", example::first_fib_loop(1));
    println!("loop_with_return_value: first number in Fibonacci sequence over 10 = {}", example::first_fib_loop_with_return_value(1));
    println!("first_fib_while: first number in Fibonacci sequence over 10 = {}", example::first_fib_while(1));
    println!("first_fib_while_let: first number in Fibonacci sequence over 10 = {}", example::first_fib_while_let(1));
    println!("first_fib_for: first number in Fibonacci sequence over 10 = {}", example::first_fib_for(1));
}
