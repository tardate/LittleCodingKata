# #xxx getImpactedCoordinates

Using ruby to calculate the blast radius of some fireworks; cassidoo's interview question of the week (2026-07-06).

## Notes

The [interview question of the week (2026-07-06)](https://buttondown.com/cassidoo/archive/u1f335-we-tell-ourselves-stories-in-order-to-live/):

> Given an n x m grid, an odd integer size, and a coordinate (row, col) representing where a firework explodes, return all grid coordinates impacted by the blast. A firework affects every cell within Math.floor(size / 2) rows and columns of the center, clipped to the grid boundaries.
>
> Example:
>
> ```ts
> > getImpactedCoordinates(5, 5, 3, 1, 1)
> > [[0,0],[0,1],[0,2],[1,0],[1,1],[1,2],[2,0],[2,1],[2,2]]
>
> > getImpactedCoordinates(3, 3, 1, 2, 1)
> > [[2,1]]
>
> > getImpactedCoordinates(5, 5, 3, 4, 4)
> > [[3,3],[3,4],[4,3],[4,4]]
> ```

### Thinking about the Problem

The problem makes things easier for us because it approximates the impact area as a square from Math.floor(size / 2) rows and columns of the center.

Since we only need to return the impacted cells, we can simply:

* calculate the coordinates of the impact area, remembering to trim to grid extents
* generate the impact area array by iterating between the coordinates

The main gotcha to look out for is to keep everything consistent to a 0-based coordinate system.

### A Solution

Here's a first go:

```ruby
def getImpactedCoordinates(grid_width, grid_height, size, center_x, center_y)
  result = []

  radius = (size / 2.0).floor
  x_min = [0, center_x - radius].max
  x_max = [grid_width - 1, center_x + radius].min
  y_min = [0, center_y - radius].max
  y_max = [grid_height - 1, center_y + radius].min

  (x_min...x_max + 1).each do |x|
    (y_min...y_max + 1).each do |y|
      result << [x, y]
    end
  end

  result
end
```

And it checks out with the given examples:

```sh
$ ./example.rb 5 5 3 1 1
[[0, 0], [0, 1], [0, 2], [1, 0], [1, 1], [1, 2], [2, 0], [2, 1], [2, 2]]
$ ./example.rb 3 3 1 2 1
[[2, 1]]
$ ./example.rb 5 5 3 4 4
[[3, 3], [3, 4], [4, 3], [4, 4]]
```

### Final Code

See [example.rb](./example.rb) for the final code.

```ruby
#!/usr/bin/env ruby

def getImpactedCoordinates(grid_width, grid_height, size, center_x, center_y)
  result = []

  radius = (size / 2.0).floor
  x_min = [0, center_x - radius].max
  x_max = [grid_width - 1, center_x + radius].min
  y_min = [0, center_y - radius].max
  y_max = [grid_height - 1, center_y + radius].min

  (x_min...x_max + 1).each do |x|
    (y_min...y_max + 1).each do |y|
      result << [x, y]
    end
  end

  result
end

if __FILE__==$PROGRAM_NAME
  (puts "Usage: ruby #{$0} n m size row col"; exit) unless ARGV.length == 5
  grid_width = ARGV[0].to_i
  grid_height = ARGV[1].to_i
  size = ARGV[2].to_f
  center_x = ARGV[3].to_i
  center_y = ARGV[4].to_i

  impacted_coordinates = getImpactedCoordinates(grid_width, grid_height, size, center_x, center_y)
  puts impacted_coordinates.inspect
end

```

### Tests

I've setup some validation in [test_example.rb](./test_example.rb):

```sh
$ ./test_example.rb
Run options: --seed 34621

# Running:

...

Finished in 0.000238s, 12605.0420 runs/s, 12605.0420 assertions/s.

3 runs, 3 assertions, 0 failures, 0 errors, 0 skips
```

## Credits and References

* [name](url)
