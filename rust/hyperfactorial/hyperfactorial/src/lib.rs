pub fn hyperfactorial(n: u32) -> u128 {
    let mut product: u128 = 1;
    for i in 1..=n {
        let base = i as u128;
        let exponent = i as u32;
        let term = base.pow(exponent);
        product *= term;
    }
    product
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_hyperfactorial_examples() {
        assert_eq!(hyperfactorial(1), 1);
        assert_eq!(hyperfactorial(2), 4);
        assert_eq!(hyperfactorial(3), 108);
        assert_eq!(hyperfactorial(7), 3_319_766_398_771_200_000u128);
    }

    #[test]
    fn test_largest_hyperfactorial() {
        assert_eq!(hyperfactorial(9), 21_577_941_222_941_856_209_168_026_828_800_000u128);
    }

    #[test]
    #[should_panic]
    fn test_hyperfactorial_overflow() {
        hyperfactorial(10);
    }
}
