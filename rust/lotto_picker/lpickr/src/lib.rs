use rand::Rng;
use std::collections::HashSet;

pub fn pick(number_count: usize, upper_limit: usize) -> HashSet<usize> {
    if number_count > upper_limit {
        panic!("Upper limit must be >= the number to pick");
    }

    let mut rng = rand::thread_rng();
    let mut choices: HashSet<usize> = HashSet::new();

    while choices.len() < number_count {
        choices.insert(rng.gen_range(1..=upper_limit));
    };
    choices
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_returns_expected_number_of_numbers() {
        assert_eq!(pick(1, 40).len(), 1);
        assert_eq!(pick(6, 40).len(), 6);
        assert_eq!(pick(12, 40).len(), 12);
    }

    #[test]
    fn test_empty_if_ask_for_zero() {
        assert_eq!(pick(0, 0).len(), 0);
    }

    #[test]
    fn test_returns_all_numbers_within_range() {
        for _ in 1..=100 {
            let result: HashSet<usize> = pick(1, 10);
            assert_eq!(result.len(), 1);
            let value = result.iter().next().unwrap();
            assert!((1..=10).contains(value));
        }
    }

    #[test]
    #[should_panic]
    fn test_fails_if_ask_for_more_numbers_than_available() {
        pick(6, 5);
    }
}
