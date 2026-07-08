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
