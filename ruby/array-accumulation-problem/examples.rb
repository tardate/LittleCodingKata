#!/usr/bin/env ruby

class ArrayAccumulationProblem
  attr_reader :input

  def initialize(input)
    @input = input
  end

  def default
    result = 0
    input.each_with_index do |value, index|
      result += value
      result += input[index - 1] if index > 0
      result += input[index + 1] if index < input.length - 1
    end
    result
  end

  def improved
    result = 0
    last_index = input.length - 1
    input.each_with_index do |value, index|
      multiplier = if last_index.zero?
        1
      elsif index.zero? || index == last_index
        2
      else
        3
      end
      result += value * multiplier
    end
    result
  end
end


if __FILE__==$PROGRAM_NAME
  (puts "Usage: ruby #{$0} (string) (algorithm)"; exit) unless ARGV.length > 0
  input = ARGV[0].split(',').map do |item|
    item.include?('.') ? item.to_f : item.to_i
  end
  algorithm = ARGV[1] || 'default'
  puts "Using algorithm: #{algorithm}"
  calculator = ArrayAccumulationProblem.new(input)
  puts "Input: #{calculator.input}"
  puts "Result: #{calculator.send(algorithm)}"
end
