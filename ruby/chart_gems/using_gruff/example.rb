#! /usr/bin/env ruby
require 'gruff'

def generate(chart_type)
  chart = send(chart_type)
  output_filename = "#{chart_type}.png"
  puts "Save to: #{output_filename}"
  chart.write(output_filename)
end

def line_chart
  g = Gruff::Line.new
  g.title = 'My Line Graph'
  # Add some data
  g.data 'Data Set 1', [1, 2, 3, 4, 5]
  g.data 'Data Set 2', [5, 4, 3, 2, 1]
  g
end

generate('line_chart')
