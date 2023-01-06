#! /usr/bin/env ruby
require 'googlecharts'

def generate(chart_type)
  chart = send(chart_type)
  puts "Chart URL: #{chart.url}"
  chart.file
end

def line_chart
  Gchart.new(
    :type => 'line',
    :size => '200x300',
    :title => "example title",
    :bg => 'efefef',
    :legend => ['first data set label', 'second data set label'],
    :data => [10, 30, 120, 45, 72],
    :filename => 'line_chart.png'
  )
end

generate('line_chart')
