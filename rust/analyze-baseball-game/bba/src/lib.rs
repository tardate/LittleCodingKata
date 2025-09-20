//! algorithms for analyzing a baseball game
//!
use serde_json::json;

/// This function implements a basic analysis of a baseball game given the innings results
pub fn analyze_baseball_game(innings: &Vec<Vec<i32>>) -> serde_json::Value {
    let mut home_total = 0;
    let mut away_total = 0;
    let mut home_led_innings = Vec::new();
    let mut away_led_innings = Vec::new();

    for (i, inning) in innings.iter().enumerate() {
        if inning.len() != 2 {
            panic!("Each inning must have exactly 2 elements (home and away scores), but found {}", inning.len());
        }
        home_total += inning[0];
        away_total += inning[1];
        if away_total > home_total {
            away_led_innings.push(i + 1);
        } else if home_total > away_total {
            home_led_innings.push(i + 1);
        }
    }

    let winner = if home_total > away_total {
        "home"
    } else if away_total > home_total {
        "away"
    } else {
        "draw"
    };

    json!({
        "homeTotal": home_total,
        "awayTotal": away_total,
        "homeLedInnings": home_led_innings,
        "awayLedInnings": away_led_innings,
        "winner": winner
    })
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_example() {
        assert_eq!(
            analyze_baseball_game(&vec![vec![1, 0], vec![2, 2], vec![0, 3], vec![4, 1]]),
            json!({
                "homeTotal": 7,
                "awayTotal": 6,
                "homeLedInnings": [1, 2, 4],
                "awayLedInnings": [3],
                "winner": "home"
            })
        );
    }

    #[test]
    fn test_home_wins() {
        assert_eq!(
            analyze_baseball_game(
                &vec![
                    vec![0, 1], vec![7, 5], vec![4, 3], vec![1, 2],
                    vec![0, 1], vec![7, 5], vec![4, 3], vec![1, 2], vec![0, 0]
                ]
            ),
            json!({
                "homeTotal": 24,
                "awayTotal": 22,
                "homeLedInnings": [2, 3, 4, 6, 7, 8, 9],
                "awayLedInnings": [1],
                "winner": "home"
            })
        );
    }

    #[test]
    fn test_away_wins() {
        assert_eq!(
            analyze_baseball_game(
                &vec![
                    vec![1, 0], vec![2, 5], vec![0, 3], vec![4, 1],
                    vec![1, 0], vec![2, 5], vec![0, 3], vec![4, 1], vec![0, 0]
                ]
            ),
            json!({
                "homeTotal": 14,
                "awayTotal": 18,
                "homeLedInnings": [1],
                "awayLedInnings": [2, 3, 4, 5, 6, 7, 8, 9],
                "winner": "away"
            })
        );
    }

    #[test]
    fn test_draw() {
        assert_eq!(
            analyze_baseball_game(
                &vec![
                    vec![1, 0], vec![2, 0], vec![2, 3], vec![0, 2],
                    vec![1, 0], vec![2, 0], vec![2, 3], vec![0, 2], vec![2, 2]
                ]
            ),
            json!({
                "homeTotal": 12,
                "awayTotal": 12,
                "homeLedInnings": [1, 2, 3, 5, 6, 7],
                "awayLedInnings": [],
                "winner": "draw"
            })
        );
    }

    #[test]
    fn test_panic_on_inning_with_less_than_2_elements() {
        let result = std::panic::catch_unwind(|| {
            analyze_baseball_game(&vec![vec![1]]);
        });
        assert!(result.is_err());
    }

    #[test]
    fn test_panic_on_inning_with_more_than_2_elements() {
        let result = std::panic::catch_unwind(|| {
            analyze_baseball_game(&vec![vec![1, 2, 3]]);
        });
        assert!(result.is_err());
    }

    #[test]
    fn test_empty_innings() {
        let result = analyze_baseball_game(&vec![]);
        assert_eq!(
            result,
            json!({
                "homeTotal": 0,
                "awayTotal": 0,
                "homeLedInnings": [],
                "awayLedInnings": [],
                "winner": "draw"
            })
        );
    }

    #[test]
    fn test_all_zero_scores() {
        assert_eq!(
            analyze_baseball_game(&vec![vec![0, 0], vec![0, 0], vec![0, 0]]),
            json!({
                "homeTotal": 0,
                "awayTotal": 0,
                "homeLedInnings": [],
                "awayLedInnings": [],
                "winner": "draw"
            })
        );
    }
}
