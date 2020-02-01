/// Trival example function with documentation and a doc test.
///
/// # Examples
///
/// ```
/// let result = tested_app::add_two(2);
/// assert_eq!(result, 4);
/// ```

pub fn add_two(a: i32) -> i32 {
    add_private(a, 2)
}

fn add_private(a: i32, b: i32) -> i32 {
    a + b
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn add_two_works() {
        assert_eq!(add_two(2), 4);
    }

    #[test]
    fn add_private_works() {
        assert_eq!(add_private(2, 2), 4, "testing private function");
    }

    #[test]
    #[should_panic]
    fn failing_test() {
        panic!("Make this test fail");
    }
}
