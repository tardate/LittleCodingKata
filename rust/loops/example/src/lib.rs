/// using various looping constructs with
/// example algorithm: first number in Fibonacci sequence over 10
///
/// These are all generally terrible ways to write this function,
/// but they serve the purpose of demonstrating the syntax

pub fn first_fib_loop(a: i32) -> i32 {
    let (mut a, mut b) = (a, a);
    loop {
        if b > 10 {
            break;
        }
        let c = a + b;
        a = b;
        b = c;
    };
    b
}

pub fn first_fib_loop_with_return_value(a: i32) -> i32 {
    let (mut a, mut b) = (a, a);
    let result = loop {
        if b > 10 {
            break b;
        }
        let c = a + b;
        a = b;
        b = c;
    };
    result | 0
}

pub fn first_fib_while(a: i32) -> i32 {
    let (mut a, mut b) = (a, a);
    while b < 10 {
        let c = a + b;
        a = b;
        b = c;
    };
    b
}

pub fn first_fib_while_let(a: i32) -> i32 {
    let (mut a, mut b) = (a, a);
    let mut x = vec![1, 2, 3, 4, 5];
    while let Some(_y) = x.pop() {
        let c = a + b;
        a = b;
        b = c;
    }
    b
}

pub fn first_fib_for(a: i32) -> i32 {
    let (mut a, mut b) = (a, a);
    let iterations = vec![1, 2, 3, 4, 5];
    for _i in iterations {
        let c = a + b;
        a = b;
        b = c;
    }
    b
}



#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn first_fib_loop_works() {
        assert_eq!(first_fib_loop(1), 13);
    }

    #[test]
    fn first_fib_loop_with_return_value_works() {
        assert_eq!(first_fib_loop_with_return_value(1), 13);
    }

    #[test]
    fn first_fib_while_works() {
        assert_eq!(first_fib_while(1), 13);
    }

    #[test]
    fn first_fib_while_let_works() {
        assert_eq!(first_fib_while_let(1), 13);
    }

    #[test]
    fn first_fib_for_works() {
        assert_eq!(first_fib_for(1), 13);
    }
}
