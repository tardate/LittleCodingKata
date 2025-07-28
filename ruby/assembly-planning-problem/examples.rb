#!/usr/bin/env ruby
require 'json'

class AssemblyPlanning
  attr_reader :input
  attr_reader :logging

  def initialize(input, logging = false)
    @input = input
    @logging = logging
  end

  def log(message)
    puts message if logging
  end

  def spt
    sorted_input = input.sort_by { |item| [item['arrivalDays'], item['assemblyHours']] }

    total_time = 0
    sorted_input.each do |item|
      arrival_days = item['arrivalDays']
      arrival_hours = arrival_days * 24
      assembly_hours = item['assemblyHours']

      wait_hours = arrival_hours > total_time ? arrival_hours - total_time : 0
      total_time += wait_hours + assembly_hours

      log "Processing #{item['name']}: Arrival Days: #{arrival_days}, Assembly Hours: #{assembly_hours}, Total Time: #{total_time}"
    end

    total_time
  end
end

if __FILE__==$PROGRAM_NAME
  (puts "Usage: ruby #{$0} (json-file) (algorithm)"; exit) unless ARGV.length > 0
  json_file_name = ARGV[0]
  algorithm = ARGV[1] || 'spt'
  begin
    input = JSON.parse(File.read(json_file_name))
  rescue
    puts "Error: Invalid JSON file - #{json_file_name}"
    exit
  end
  puts "Using algorithm: #{algorithm}"
  calculator = AssemblyPlanning.new(input, true)
  puts "Input array: #{calculator.input.inspect}"
  puts "Result: #{calculator.send(algorithm)}"
end
