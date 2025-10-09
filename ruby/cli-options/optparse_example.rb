#! /usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'
require 'optparse/date'

options = {}
OptionParser.new do |parser|
  parser.banner = "Usage: example.rb [options]"
  parser.on('-a', '--array=ARRAY', Array, 'provide a comma-separated list of values') # e.g., --array val1,val2,val3
  parser.on('-d', '--date=DATE', Date, 'provide a date (in the format YYYY-MM-DD)') # e.g., --date 2023-10-31
  parser.on('-v', '--[no-]verbose', 'Run verbosely')
  parser.on('-o', '--output FILE', 'Write to FILE')
  parser.on '-t', '--[no-]timeout [TIMEOUT]', Numeric, 'Timeout (in seconds) before timer aborts the run (Default: 1.8)' do |timeout|
    if timeout.is_a?(Numeric)
      timeout
    elsif timeout.nil?
      1.8
    elsif timeout == false
      -1
    end
  end
end.parse!(into: options)

puts "Options: #{options.inspect}"
puts "Array: #{options[:array].inspect}" if options[:array]
puts "Date: #{options[:date].inspect}" if options[:date]
puts "Output to #{options[:output]}" if options[:output]
puts "Timeout: #{options[:timeout].inspect}" if options[:timeout]
puts "Verbose output..." if options[:verbose]
