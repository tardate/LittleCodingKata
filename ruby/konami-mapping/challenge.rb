#!/usr/bin/env ruby
# frozen_string_literal: true

def apply_mapping(input, mapping)
  result = input.dup
  mapping.each do |given, substitute|
    result.gsub!(given, substitute)
  end
  result
end

def pattern_signature(input)
  mapping = {}
  next_code = 0
  signature = []

  input.each_char do |char|
    unless mapping.key?(char)
      mapping[char] = next_code
      next_code = next_code + 1
    end
    signature << mapping[char]
  end

  signature
end

def bijective_mapping(source, destination)
  mapping = {}
  destination.chars.each_with_index do |destination_char, index|
    given_char = source[index]
    mapping[given_char] = destination_char
  end
  mapping
end

def konamiMapping(input)
  Calculator.new(input).default
end

class Calculator
  attr_reader :input

  KONAMI_CODE = 'UUDDLRLRBA'

  def initialize(input)
    @input = input
  end

  def konami_signature
    @konami_signature ||= pattern_signature(KONAMI_CODE)
  end

  def konami_length
    @konami_length ||= KONAMI_CODE.length
  end

  def default
    (0..(input.length - konami_length)).each do |start_index|
      substring = input[start_index, konami_length]
      if pattern_signature(substring) == konami_signature
        return bijective_mapping(substring, KONAMI_CODE)
      end
    end

    nil
  end
end

if __FILE__==$PROGRAM_NAME
  (puts "Usage: ruby #{$0} (string)"; exit) unless ARGV.length > 0
  input = ARGV[0]
  algorithm = ARGV[1] || 'default'
  calculator = Calculator.new(input)
  result = calculator.send(algorithm)
  mapped = apply_mapping(input, result) if result
  puts "Input String: #{calculator.input}"
  puts "Mapped String: #{mapped}"
  puts "Result: #{result}"
end
