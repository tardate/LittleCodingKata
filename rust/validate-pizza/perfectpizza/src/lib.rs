//! algorithms for validating a pizza recipe
//!
use serde_json;

/// This function implements the validation of pizza rules given a layers recipe.
pub fn validate_pizza(layers: &Vec<String>, rules: &Vec<Vec<String>>) -> String {
    for rule in rules {
      if rule.len() < 2 {
        continue;
      }
      let ingredient_a = &rule[0];
      let ingredient_b = &rule[1];

      if let (Some(index_a), Some(index_b)) = (
        layers.iter().position(|x| x == ingredient_a),
        layers.iter().position(|x| x == ingredient_b),
      ) {
        if index_a >= index_b {
          // return rule.join(",");
          return serde_json::to_string(&rule).unwrap();
        }
      }
    }
    "true".to_string()
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_example1() {
        assert_eq!(
            validate_pizza(
              &vec!["dough", "sauce", "cheese", "pepperoni", "basil"].iter().map(|s| s.to_string()).collect(),
              &vec![
                vec!["sauce", "cheese"].iter().map(|s| s.to_string()).collect(),
                vec!["cheese", "pepperoni"].iter().map(|s| s.to_string()).collect(),
                vec!["dough", "basil"].iter().map(|s| s.to_string()).collect(),
              ]
            ),
            "true"
        );
    }

    #[test]
    fn test_example2() {
        assert_eq!(
            validate_pizza(
              &vec!["dough", "sauce", "cheese", "pepperoni", "basil"].iter().map(|s| s.to_string()).collect(),
              &vec![
                vec!["cheese", "pepperoni"].iter().map(|s| s.to_string()).collect(),
                vec!["cheese", "sauce"].iter().map(|s| s.to_string()).collect(),
              ]
            ),
            "[\"cheese\",\"sauce\"]"
        );
    }
}
