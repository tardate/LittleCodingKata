#[allow(dead_code)]
fn days_in_month(year: u32, month: u32) -> u32 {
    match month {
        1 | 3 | 5 | 7 | 8 | 10 | 12 => 31,
        4 | 6 | 9 | 11 => 30,
        2 => {
            if year % 4 == 0 && (year % 100 != 0 || year % 400 == 0) {
                29
            } else {
                28
            }
        }
        _ => panic!("Invalid month: {}. Must be between 1 and 12.", month),
    }
}

#[allow(dead_code)]
fn is_sunday_zeller(year: u32, month: u32, day: u32) -> bool {
    let mut y = year;
    let mut m = month;

    if m < 3 {
        m += 12;
        y -= 1;
    }

    let k = y % 100;
    let j = y / 100;

    let h = (day + (13 * (m + 1)) / 5 + k + k / 4 + j / 4 - 2 * j) % 7;

    h == 1
}

#[allow(dead_code)]
fn days_in_month_chrono(year: u32, month: u32) -> u32 {
    use chrono::Month;
    use std::convert::TryFrom;

    let m = Month::try_from(month as u8)
        .unwrap_or_else(|_| panic!("Invalid month: {}. Must be between 1 and 12.", month));

    m.num_days(year as i32)
        .unwrap_or_else(|| panic!("Invalid year provided: {}", year)) as u32
}

#[allow(dead_code)]
fn is_sunday_chrono(year: u32, month: u32, day: u32) -> bool {
    use chrono::NaiveDate;
    use chrono::Datelike;

    let date = NaiveDate::from_ymd_opt(year as i32, month, day).expect("Invalid date");
    date.weekday() == chrono::Weekday::Sun
}

pub fn get_sundays(yyyy: u32, mm: u32) -> Vec<String> {
    let mut result = Vec::new();
    let mut day = 1;
    while day <= days_in_month(yyyy, mm) {
      if is_sunday_zeller(yyyy, mm, day) {
        result.push(format!("{:04}-{:02}-{:02}", yyyy, mm, day));
        day += 7;
      } else {
        day += 1;
      }
    }
    result
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_days_in_month() {
        assert_eq!(days_in_month(2024, 2), 29);
        assert_eq!(days_in_month(2026, 2), 28);
        assert_eq!(days_in_month(2026, 9), 30);
        assert_eq!(days_in_month(2026, 12), 31);
    }

    #[test]
    fn test_is_sunday_zeller() {
        assert_eq!(is_sunday_zeller(2026, 1, 3), false);
        assert_eq!(is_sunday_zeller(2026, 1, 4), true);
        assert_eq!(is_sunday_zeller(2026, 1, 5), false);
        assert_eq!(is_sunday_zeller(2026, 9, 1), false);
        assert_eq!(is_sunday_zeller(2026, 9, 5), false);
        assert_eq!(is_sunday_zeller(2026, 9, 6), true);
        assert_eq!(is_sunday_zeller(2026, 9, 7), false);
        assert_eq!(is_sunday_zeller(2026, 9, 13), true);
        assert_eq!(is_sunday_zeller(2026, 9, 20), true);
        assert_eq!(is_sunday_zeller(2026, 9, 27), true);
    }

    #[test]
    fn test_days_in_month_chrono() {
        assert_eq!(days_in_month_chrono(2024, 2), 29);
        assert_eq!(days_in_month_chrono(2026, 2), 28);
        assert_eq!(days_in_month_chrono(2026, 9), 30);
        assert_eq!(days_in_month_chrono(2026, 12), 31);
    }

    #[test]
    fn test_is_sunday_chrono() {
        assert_eq!(is_sunday_chrono(2026, 1, 3), false);
        assert_eq!(is_sunday_chrono(2026, 1, 4), true);
        assert_eq!(is_sunday_chrono(2026, 1, 5), false);
        assert_eq!(is_sunday_chrono(2026, 9, 1), false);
        assert_eq!(is_sunday_chrono(2026, 9, 5), false);
        assert_eq!(is_sunday_chrono(2026, 9, 6), true);
        assert_eq!(is_sunday_chrono(2026, 9, 7), false);
        assert_eq!(is_sunday_chrono(2026, 9, 13), true);
        assert_eq!(is_sunday_chrono(2026, 9, 20), true);
        assert_eq!(is_sunday_chrono(2026, 9, 27), true);
    }

    #[test]
    fn test_example1() {
        assert_eq!(get_sundays(2026, 9), [ "2026-09-06", "2026-09-13", "2026-09-20", "2026-09-27" ]);
    }

    #[test]
    fn test_example2() {
        assert_eq!(get_sundays(2024, 2), [ "2024-02-04", "2024-02-11", "2024-02-18", "2024-02-25" ]);
    }

    #[test]
    fn test_2026_jan() {
        assert_eq!(get_sundays(2026, 1), [ "2026-01-04", "2026-01-11", "2026-01-18", "2026-01-25" ]);
    }

    #[test]
    fn test_2026_feb() {
        assert_eq!(get_sundays(2026, 2), [ "2026-02-01", "2026-02-08", "2026-02-15", "2026-02-22" ]);
    }

    #[test]
    fn test_2026_mar() {
        assert_eq!(get_sundays(2026, 3), [ "2026-03-01", "2026-03-08", "2026-03-15", "2026-03-22", "2026-03-29" ]);
    }

    #[test]
    fn test_2026_dec() {
        assert_eq!(get_sundays(2026, 12), [ "2026-12-06", "2026-12-13", "2026-12-20", "2026-12-27" ]);
    }

    #[test]
    #[should_panic]
    fn test_month_too_large() {
        get_sundays(2023, 13);
    }

    #[test]
    #[should_panic]
    fn test_month_too_small() {
        get_sundays(2023, 0);
    }
}
