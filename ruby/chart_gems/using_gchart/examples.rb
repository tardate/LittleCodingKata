#! /usr/bin/env ruby
require 'gchart'

def generate(chart_type)
  chart = send(chart_type)
  url = chart.to_url
  output_filename = "#{chart_type}.png"
  puts "Chart URL: #{url}"
  puts "Writing to: #{output_filename}"
  chart.write(output_filename)
end

def line_chart
  GChart.line(:data => [[1, 2], [3, 4]], :extras => { "chdl" => "First|Second"})
end

generate('line_chart')
