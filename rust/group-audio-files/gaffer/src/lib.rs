//! algorithms for grouping audio files into playlists
//!

/// This function implements the First Fit Decreasing (FFD) algorithm to group audio files
pub fn ffd(durations: Vec<i32>, max_duration: i32) -> Vec<Vec<i32>> {
  let mut result: Vec<Vec<i32>> = Vec::new();
  let mut sorted_durations = durations.clone();
  sorted_durations.sort_by(|a, b| b.cmp(a));
  for duration in sorted_durations {
      let mut added = false;
      for group in &mut result {
          let total: i32 = group.iter().sum();
          if total + duration <= max_duration {
              group.push(duration);
              added = true;
              break;
          }
      }
      if !added {
          result.push(vec![duration]);
      }
  }
  result
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn ffd_works_with_example1() {
        assert_eq!(
            ffd(vec![120, 90, 60, 150, 80], 200),
            vec![vec![150], vec![120, 80], vec![90, 60]]
        );
    }

    #[test]
    fn ffd_works_with_example2() {
        assert_eq!(
            ffd(vec![120, 90, 60, 150, 80], 160),
            vec![vec![150], vec![120], vec![90,60], vec![80]]
        );
    }

    #[test]
    fn ffd_handles_songs_longer_than_playlist() {
        assert_eq!(
            ffd(vec![120, 90, 60, 150, 80], 140),
            vec![vec![150], vec![120], vec![90], vec![80, 60]]
        );
    }
}
