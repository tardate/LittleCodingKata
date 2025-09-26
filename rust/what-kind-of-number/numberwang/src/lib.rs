//! algorithms for calculating the aliquot sum of a number, prime factors, and classifying numbers
//!

/// Naïve O(√n) algorithm: walk through all possible divisors.
/// Returns the sum of proper divisors of `n`.
pub fn aliquot_sum_naive(n: u64) -> u64 {
    if n == 0 { return 0; } // by convention 0 has no proper divisors
    if n == 1 { return 0; } // 1 has no proper divisor other than 0

    let mut sum = 1; // 1 is always a proper divisor for n > 1
    let limit = (n as f64).sqrt() as u64;

    for d in 2..=limit {
        if n % d == 0 {
            let other = n / d;
            if d == other {
                sum += d; // d is a perfect square root, add it only once
            } else {
                sum += d + other; // add both members of the divisor pair
            }
        }
    }
    sum
}

/// Simple trial‑division prime factorisation: returns a vector of
/// (prime, exponent) pairs.  Works fine for numbers up to ≈10¹²‑10¹³
/// with the naïve trial divisor; for huge numbers you would swap in a
/// faster factorizer (Pollard‑Rho, Miller‑Rabin, etc.).
fn prime_factors(mut n: u64) -> Vec<(u64, u32)> {
    let mut factors = Vec::new();

    // factor out the 2s first – this avoids a division test inside the loop
    let mut cnt = 0;
    while n % 2 == 0 {
        n /= 2;
        cnt += 1;
    }
    if cnt > 0 {
        factors.push((2, cnt));
    }

    // odd candidates only
    let mut p = 3;
    while p * p <= n {
        if n % p == 0 {
            let mut cnt = 0;
            while n % p == 0 {
                n /= p;
                cnt += 1;
            }
            factors.push((p, cnt));
        }
        p += 2;
    }

    // whatever is left is prime (unless it is 1)
    if n > 1 {
        factors.push((n, 1));
    }
    factors
}

/// Computes σ(n) – the sum of *all* positive divisors of n – from
/// its prime factorisation using the well‑known product formula: σ(n) = ∏ (p_i^{e_i+1} - 1) / (p_i - 1)
fn sigma_from_factors(factors: &[(u64, u32)]) -> u64 {
    let mut result: u128 = 1; // use a wider type to avoid overflow in intermediate steps

    for &(p, e) in factors {
        // compute p^{e+1}
        let mut power: u128 = 1;
        for _ in 0..=e {
            power *= p as u128;
        }
        // (p^{e+1} - 1) / (p - 1)
        let term = (power - 1) / ((p as u128) - 1);
        result *= term;
    }

    // The final result *should* fit into u64 for any input that fits into u64.
    // If it doesn't, we just truncate (the caller can decide what to do).
    result as u64
}

/// Fast aliquot sum using the factorisation → σ → s(n) = σ(n) - n chain.
pub fn aliquot_sum_fast(n: u64) -> u64 {
    if n == 0 || n == 1 {
        return 0;
    }
    let factors = prime_factors(n);
    let sigma = sigma_from_factors(&factors);
    sigma - n
}

/// Classifies a number as "deficient", "perfect", or "abundant"
/// using the specified algorithm ("fast" or "naive") to compute the aliquot sum
pub fn what_kind_of_number(n: u64, algorithm: &str) -> &'static str {
    let aliquot_sum = match algorithm {
        "fast" => aliquot_sum_fast(n),
        _ => aliquot_sum_naive(n),
    };

    let classification = if aliquot_sum < n {
        "deficient"
    } else if aliquot_sum == n {
        "perfect"
    } else {
        "abundant"
    };
    classification
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_aliquot_sum_naive() {
        assert_eq!(aliquot_sum_naive(0), 0);
        assert_eq!(aliquot_sum_naive(1), 0);
        assert_eq!(aliquot_sum_naive(6), 6);   // perfect
        assert_eq!(aliquot_sum_naive(12), 16); // abundant
        assert_eq!(aliquot_sum_naive(15), 9);  // deficient
        assert_eq!(aliquot_sum_naive(28), 28); // perfect
        assert_eq!(aliquot_sum_naive(97), 1);  // prime, deficient
    }

    #[test]
    fn test_aliquot_sum_fast() {
        assert_eq!(aliquot_sum_fast(0), 0);
        assert_eq!(aliquot_sum_fast(1), 0);
        assert_eq!(aliquot_sum_fast(6), 6);   // perfect
        assert_eq!(aliquot_sum_fast(12), 16); // abundant
        assert_eq!(aliquot_sum_fast(15), 9);  // deficient
        assert_eq!(aliquot_sum_fast(28), 28); // perfect
        assert_eq!(aliquot_sum_fast(97), 1);  // prime, deficient
    }

    fn what_kind_of_number_suite(algorithm: &str) {
        assert_eq!(what_kind_of_number(6, algorithm), "perfect");
        assert_eq!(what_kind_of_number(28, algorithm), "perfect");
        assert_eq!(what_kind_of_number(496, algorithm), "perfect");
        assert_eq!(what_kind_of_number(8128, algorithm), "perfect");
        assert_eq!(what_kind_of_number(1, algorithm), "deficient");
        assert_eq!(what_kind_of_number(2, algorithm), "deficient");
        assert_eq!(what_kind_of_number(3, algorithm), "deficient");
        assert_eq!(what_kind_of_number(4, algorithm), "deficient");
        assert_eq!(what_kind_of_number(15, algorithm), "deficient");
        assert_eq!(what_kind_of_number(97, algorithm), "deficient");
        assert_eq!(what_kind_of_number(12, algorithm), "abundant");
        assert_eq!(what_kind_of_number(18, algorithm), "abundant");
        assert_eq!(what_kind_of_number(20, algorithm), "abundant");
        assert_eq!(what_kind_of_number(24, algorithm), "abundant");
    }

    #[test]
    fn test_what_kind_of_number_naive() {
        what_kind_of_number_suite("naive");
    }

    #[test]
    fn test_what_kind_of_number_fast() {
        what_kind_of_number_suite("fast");
    }
}
