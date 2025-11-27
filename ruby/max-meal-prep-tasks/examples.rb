#!/usr/bin/env ruby
require 'json'

class MealPlanner
  attr_reader :input
  attr_reader :logging

  def initialize(input, logging = false)
    @input = input
    @logging = logging
  end

  def log(message)
    puts message if logging
  end

  def minAssemblyTime
    sorted_input = input.sort_by { |item| [item[1], item[2]] }

    result = { count: 0, chosen: [] }
    current_start = 0
    sorted_input.each do |item|
      name, start_at, end_at = item
      next unless start_at >= current_start

      log "Adding #{item}: start_at: #{start_at}, end_at: #{end_at}"
      current_start = end_at
      result[:count] += 1
      result[:chosen] << name
    end

    result
  end
end

if __FILE__ == $PROGRAM_NAME
  (puts "Usage: ruby #{$0} (json-file)"; exit) unless ARGV.length > 0
  json_file_name = ARGV[0]
  begin
    input = JSON.parse(File.read(json_file_name))
  rescue
    puts "Error: Invalid JSON file - #{json_file_name}"
    exit
  end
  calculator = MealPlanner.new(input, true)
  puts "Input array: #{calculator.input.inspect}"
  puts "Result: #{calculator.minAssemblyTime}"
end
