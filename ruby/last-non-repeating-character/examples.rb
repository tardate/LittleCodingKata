#!/usr/bin/env ruby

class LastNonRepeatingCharacter
  attr_reader :input

  def initialize(input)
    @input = input
  end

  def copilot_suggested
    char_count = Hash.new(0)
    input.each_char { |char| char_count[char] += 1 }
    input.reverse.each_char do |char|
      return char if char_count[char] == 1
    end
    nil
  end

  def idiomatic_ruby_by_copilot
    char_count = input.each_char.tally
    input.reverse.each_char.find { |char| char_count[char] == 1 }
  end

  def one_liner
    input.reverse.each_char.find { |char| input.count(char) == 1 }
  end
end


if __FILE__==$PROGRAM_NAME
  (puts "Usage: ruby #{$0} (string) (algorithm)"; exit) unless ARGV.length > 0
  input = ARGV[0]
  algorithm = ARGV[1] || 'one_liner'
  puts "Using algorithm: #{algorithm}"
  calculator = LastNonRepeatingCharacter.new(input)
  puts "Input String: #{calculator.input}"
  puts "Result: #{calculator.send(algorithm)}"
end
