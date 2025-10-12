#!/usr/bin/env ruby
# frozen_string_literal: true

require 'json'
require 'time'

class ChangeLogGrouper
  attr_reader :input
  attr_reader :logging

  def initialize(input, logging = false)
    @input = input
    @logging = logging
  end

  def initial_solution
    result = []
    logs_by_component = input.group_by { |entry| entry['component'] }
    logs_by_component.keys.sort.each do |key|
      log_times = logs_by_component[key].map { |entry| Time.parse(entry['timestamp']) }.sort
      current_log_start = nil
      log_times.size.times do |i|
        current_log_start ||= log_times[i]
        if log_times[i + 1].nil? || (log_times[i + 1] - current_log_start) > 10 * 60
          result << { 'component' => key, 'start' => current_log_start.utc.iso8601, 'end' => log_times[i].utc.iso8601 }
          current_log_start = nil
        end
      end
    end
    result
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
  calculator = ChangeLogGrouper.new(input, true)
  puts "Input array: #{JSON.pretty_generate(calculator.input)}"
  puts "Result: #{JSON.pretty_generate(calculator.send(algorithm))}"
end
