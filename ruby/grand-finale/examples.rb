#!/usr/bin/env ruby
require 'json'

class GrandFinale
  attr_reader :input
  attr_reader :logging

  def initialize(input, logging = false)
    @input = input
    @logging = logging
  end

  def max_length
    @max_length ||= input.size
  end

  def input_sizes
    @input_sizes ||= input.map { |item| item['size'] }
  end

  def input_heights
    @input_heights ||= input.map { |item| item['height'] }
  end

  def input_velocities
    @input_velocities ||= input.map { |item| item['velocity'] }
  end

  def log_result(result)
    puts "Longest sub-array found: #{result}" if logging
  end

  def valid?(start, finish)
    sizes = input_sizes[start..finish]
    heights = input_heights[start..finish]
    velocities = input_velocities[start..finish]

    average_size = sizes.sum / sizes.size.to_f
    minimum_velocity = velocities.min
    maximum_height = heights.max
    minimum_height = heights.min

    average_size >= 5 &&
    minimum_velocity == 3 &&
    maximum_height - minimum_height <= 10
  end

  def initial_solution
    result = {length: 0}
    max_length.times do |start|
      (start..max_length - 1).each do |finish|
        length = finish - start + 1
        result = {start: start, finish: finish, length: length} if length > result[:length] && valid?(start, finish)
      end
    end
    log_result(result)
    result[:start]
  end
end

if __FILE__==$PROGRAM_NAME
  (puts "Usage: ruby #{$0} (json-file) (algorithm)"; exit) unless ARGV.length > 0
  json_file_name = ARGV[0]
  algorithm = ARGV[1] || 'initial_solution'
  begin
    input = JSON.parse(File.read(json_file_name))
  rescue
    puts "Error: Invalid JSON file - #{json_file_name}"
    exit
  end
  puts "Using algorithm: #{algorithm}"
  calculator = GrandFinale.new(input, true)
  puts "Input array: #{calculator.input.inspect}"
  puts "Result: #{calculator.send(algorithm)}"
end
