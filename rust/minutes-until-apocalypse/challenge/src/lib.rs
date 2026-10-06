//! algorithms for surviving the zombie apocalypse
//!

/// This function implements the logic for calculating minutes until the zombie apocalypse.
pub fn minutes_until_apocalypse(grid: &Vec<Vec<i32>>) -> i32 {
    let mut current_grid = grid.clone();
    let mut iterations = 0;
    let rows = current_grid.len();
    let cols = current_grid[0].len();
    let directions = [(-1, 0), (1, 0), (0, -1), (0, 1)];

    loop {
        let mut next_grid = current_grid.clone();
        let mut mutations = false;

        for i in 0..rows {
            for j in 0..cols {
                if current_grid[i][j] == 2 {
                    // Spread to adjacent cells (up, down, left, right)
                    for (di, dj) in &directions {
                        let ni = (i as i32 + di) as usize;
                        let nj = (j as i32 + dj) as usize;
                        if ni < rows && nj < cols && current_grid[ni][nj] == 1 {
                            next_grid[ni][nj] = 2;
                            mutations = true;
                        }
                    }
                }
            }
        }

        if !mutations {
            // Check if any humans remain
            for row in &next_grid {
                if row.iter().any(|&cell| cell == 1) {
                    return -1;
                }
            }
            return iterations;
        }

        current_grid = next_grid;
        iterations += 1;
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_example1() {
        assert_eq!(
            minutes_until_apocalypse(
              &vec![[2, 1, 1].to_vec(), [1, 1, 0].to_vec(), [0, 1, 1].to_vec()]
            ),
            4
        );
    }

    #[test]
    fn test_example2() {
        assert_eq!(
            minutes_until_apocalypse(
              &vec![[2, 1, 1].to_vec(), [0, 1, 1].to_vec(), [1, 0, 1].to_vec()]
            ),
            -1
        );
    }
}
