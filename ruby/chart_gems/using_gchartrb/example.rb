#! /usr/bin/env ruby
require 'google_chart'

def generate(chart_type)
  url = send(chart_type)
  output_filename = "#{chart_type}.png"
  puts "Chart URL: #{url}"
  puts "Using wget to save to: #{output_filename}"
  system(%{wget "#{url}" -O "#{output_filename}"})
end

def line_chart
  chart = GoogleChart::LineChart.new('320x200', "Line Chart", false) do |lc|
    lc.data "Trend 1", [5,4,3,1,3,5,6], '0000ff'
    lc.show_legend = true
    lc.data "Trend 2", [1,2,3,4,5,6], '00ff00'
    lc.data "Trend 3", [6,5,4,3,2,1], 'ff0000'
    lc.axis :y, :range => [0,6], :color => 'ff00ff', :font_size => 16, :alignment => :center
    lc.axis :x, :range => [0,6], :color => '00ffff', :font_size => 16, :alignment => :center
    lc.grid :x_step => 100.0/6.0, :y_step => 100.0/6.0, :length_segment => 1, :length_blank => 0
  end
  chart.to_url
end

generate('line_chart')
