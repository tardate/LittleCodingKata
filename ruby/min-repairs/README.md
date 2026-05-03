# #xxx minRepairs

Using Ruby to make minimum repairs to a broken array; cassidoo's interview question of the week (2026-04-27).

## Notes

The [interview question of the week (2026-04-27)](https://buttondown.com/cassidoo/archive/u1f57a-there-is-power-in-being-robbed-still/):

> You are given a 2D grid where 1 represents an intact tile and 0 represents a broken tile. A "broken region" is a group of connected 0s (connected horizontally or vertically). Find the minimum number of tiles you need to repair to ensure no broken region has an area larger than k.
>
> Examples:
>
> ```ts
> const grid = [
>   [1, 0, 0, 1],
>   [1, 0, 0, 1],
>   [1, 1, 0, 1],
>   [0, 1, 1, 1],
> ];
> const k = 2;
>
> let newGrid = [
>   [1, 0, 0, 1],
>   [1, 0, 0, 1],
>   [1, 1, 0, 1],
>   [0, 0, 1, 1],
> ];
> let newK = 1;
>
> minRepairs(grid, k)
> > 2
>
> minRepairs(newGrid, newK)
> > 3
> ```

## Thinking about the Problem

Finding the area of broken ("0") regions is relatively trivial. Deciding how to best break them apart is not?

Intuitively, it seems that "0" cells with the largest number of horizontal and vertical neighbouring "0"s should be the first to be repaired.

## A first approach

I've adapted the intuitive approach:

* compile all the regions larger than allowed
* "repair" the panel in each region with the most neighboring cells
* repeat until all regions cleared

The essential code:

```ruby
def minRepairs
    result = 0
    loop do
      regions = extractRegions
      break if regions.empty?

      regions.each_with_index do |region, idx|
        max_neighbors = 0
        cell_to_repair = nil

        region.each do |ci, cj|
          neighbors = 0
          [[0, 1], [0, -1], [1, 0], [-1, 0]].each do |di, dj|
            ni, nj = ci + di, cj + dj
            neighbors += 1 if region.include?([ni, nj])
          end
          if neighbors > max_neighbors
            max_neighbors = neighbors
            cell_to_repair = [ci, cj]
          end
        end
        if cell_to_repair
          input[cell_to_repair[0]][cell_to_repair[1]] = 1
          result += 1
        end
      end
    end
    result
  end
end
```

How does it fare? The data for the first example is in [data1.json](./data1.json), and the answer is correct for k=2:

```sh

$ cat data1.json
[
  [1, 0, 0, 1],
  [1, 0, 0, 1],
  [1, 1, 0, 1],
  [0, 1, 1, 1]
]
$ ./examples.rb
Usage: ruby ./examples.rb <json-file> <k>
$ ./examples.rb data1.json 2
Input array: [[1, 0, 0, 1], [1, 0, 0, 1], [1, 1, 0, 1], [0, 1, 1, 1]]
k: 2
Broken regions: [[[0, 1], [0, 2], [1, 1], [1, 2], [2, 2]]]
Repaired [1, 2], repairs: 1
Broken regions: [[[0, 1], [0, 2], [1, 1]]]
Repaired [0, 1], repairs: 2
Broken regions: []
Result: 2
```

The data for the second example is in [data1.json](./data2.json), and the answer is correct for k=3:

```sh

$ cat data2.json
[
  [1, 0, 0, 1],
  [1, 0, 0, 1],
  [1, 1, 0, 1],
  [0, 0, 1, 1]
]
$ ./examples.rb data2.json 1
Input array: [[1, 0, 0, 1], [1, 0, 0, 1], [1, 1, 0, 1], [0, 0, 1, 1]]
k: 1
Broken regions: [[[0, 1], [0, 2], [1, 1], [1, 2], [2, 2]], [[3, 0], [3, 1]]]
Repaired [1, 2], repairs: 1
Repaired [3, 0], repairs: 2
Broken regions: [[[0, 1], [0, 2], [1, 1]]]
Repaired [0, 1], repairs: 3
Broken regions: []
Result: 3
```

### Tests

I've setup some validation in [test_examples.rb](./test_examples.rb):

```sh
$ ./test_examples.rb
Run options: --seed 20195

# Running:

..

Finished in 0.000321s, 6230.5296 runs/s, 6230.5296 assertions/s.

2 runs, 2 assertions, 0 failures, 0 errors, 0 skips
```

### Example Code

Final code is in [examples.rb](./examples.rb):

```ruby
#!/usr/bin/env ruby

require 'json'

class Repairer
  attr_reader :input
  attr_reader :k
  attr_reader :logging

  def initialize(input, k, logging = false)
    @input = input
    @k = k
    @logging = logging
  end

  def log(message)
    puts message if logging
  end

  def extractRegions
    visited = Array.new(input.length) { Array.new(input[0].length, false) }
    result = []

    input.each_with_index do |row, i|
      row.each_with_index do |cell, j|
        next if visited[i][j] || cell == 1

        # BFS to find connected broken tiles
        region = []
        queue = [[i, j]]
        visited[i][j] = true

        while queue.any?
          ci, cj = queue.shift
          region << [ci, cj]

          [[0, 1], [0, -1], [1, 0], [-1, 0]].each do |di, dj|
            ni, nj = ci + di, cj + dj
            next if ni < 0 || ni >= input.length || nj < 0 || nj >= input[0].length
            next if visited[ni][nj] || input[ni][nj] == 1

            visited[ni][nj] = true
            queue << [ni, nj]
          end
        end

        result << region if region.length > k
      end
    end
    result
  end

  def minRepairs
    result = 0
    loop do
      regions = extractRegions
      log "Broken regions: #{regions.inspect}"
      break if regions.empty?

      # in each region, find the cell with the most neighbors and "repair it" (delete it and inc result)
      # Find the cell with the most neighbors in any region
      regions.each_with_index do |region, idx|
        max_neighbors = 0
        cell_to_repair = nil

        region.each do |ci, cj|
          neighbors = 0
          [[0, 1], [0, -1], [1, 0], [-1, 0]].each do |di, dj|
            ni, nj = ci + di, cj + dj
            neighbors += 1 if region.include?([ni, nj])
          end
          if neighbors > max_neighbors
            max_neighbors = neighbors
            cell_to_repair = [ci, cj]
          end
        end
        if cell_to_repair
          input[cell_to_repair[0]][cell_to_repair[1]] = 1
          result += 1
          log "Repaired #{cell_to_repair}, repairs: #{result}"
        end
      end
    end

    result
  end
end

if __FILE__ == $PROGRAM_NAME
  (puts "Usage: ruby #{$0} <json-file> <k>"; exit) unless ARGV.length > 1
  json_file_name = ARGV[0]
  begin
    input = JSON.parse(File.read(json_file_name))
  rescue
    puts "Error: Invalid JSON file - #{json_file_name}"
    exit
  end
  k = ARGV[1].to_i
  calculator = Repairer.new(input, k, true)
  puts "Input array: #{calculator.input.inspect}"
  puts "k: #{calculator.k.inspect}"
  puts "Result: #{calculator.minRepairs}"
end
```

## Credits and References

* [cassidoo's interview question of the week (2026-04-27)](https://buttondown.com/cassidoo/archive/u1f57a-there-is-power-in-being-robbed-still/)
