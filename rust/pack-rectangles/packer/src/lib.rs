pub fn pack_rectangles(n: usize, m: usize, a: usize, b: usize) -> usize {
    if n == 0 || m == 0 || a == 0 || b == 0 {
        return 0;
    }
    let orientation1 = (n / a) * (m / b);
    let orientation2 = (n / b) * (m / a);
    orientation1.max(orientation2)
}

pub fn pack_rectangles_v1(n: usize, m: usize, a: usize, b: usize) -> usize {
    if n == 0 || m == 0 || a == 0 || b == 0 {
        return 0;
    }

    // packed[h] = maximum number of rectangles packed in exactly h units of height.
    let mut packed = vec![None; m + 1];
    packed[0] = Some(0);

    for h in 0..=m {
        let Some(current) = packed[h] else {
            continue;
        };

        // Small rectangle is a high x b wide.
        if a <= m && b <= n && h + a <= m {
            let count = n / b;
            let value = current + count;

            packed[h + a] = Some(
                packed[h + a]
                    .map_or(value, |old| old.max(value))
            );
        }

        // Rotated: b high x a wide.
        if b <= m && a <= n && h + b <= m {
            let count = n / a;
            let value = current + count;

            packed[h + b] = Some(
                packed[h + b]
                    .map_or(value, |old| old.max(value))
            );
        }
    }

    packed.into_iter()
        .flatten()
        .max()
        .unwrap_or(0)
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_pack_rectangles_example1() {
        assert_eq!(pack_rectangles(10, 10, 3, 4), 6);
    }

    #[test]
    fn test_pack_rectangles_example2() {
        assert_eq!(pack_rectangles(10, 6, 2, 3), 10);
    }

    #[test]
    fn test_pack_rectangles_example3() {
        assert_eq!(pack_rectangles(10, 6, 11, 2), 0);
    }


    #[test]
    fn test_pack_rectangles_v1_example1() {
        assert_eq!(pack_rectangles_v1(10, 10, 3, 4), 7);
    }

    #[test]
    fn test_pack_rectangles_v1_example2() {
        assert_eq!(pack_rectangles_v1(10, 6, 2, 3), 10);
    }

    #[test]
    fn test_pack_rectangles_v1_example3() {
        assert_eq!(pack_rectangles_v1(10, 6, 11, 2), 0);
    }
}
