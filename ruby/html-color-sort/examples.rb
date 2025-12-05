#!/usr/bin/env ruby

require 'benchmark/ips'

def merge_sort_impl(array)
  return array if array.length <= 1

  mid = array.length / 2
  left = merge_sort_impl(array[0...mid])
  right = merge_sort_impl(array[mid..-1])

  merge(left, right)
end

def merge(left, right)
  result = []
  until left.empty? || right.empty?
    if left.first <= right.first
      result << left.shift
    else
      result << right.shift
    end
  end
  result + left + right
end

class HexStringSorter
  attr_reader :input
  attr_reader :logging

  def initialize(input, logging = false)
    @input = input
    @logging = logging
  end

  def log(message)
    puts message if logging
  end

  def numeric_input
    @numeric_input ||= input.map { |s| s.to_s.strip.sub(/\A0x/i, '').sub(/\A#/, '').to_i(16) }
  end

  def as_hex_string_array(result)
    result.map { |n| n.to_s(16).upcase.rjust(6, '0') }
  end

  def postman
    result = []
    numeric_input.each do |new_item|
      inserted = false
      result.each_with_index do |item, index|
        if new_item < item
          result.insert(index, new_item)
          inserted = true
          log("Inserted #{new_item.to_s(16).upcase.rjust(6, '0')} before #{item.to_s(16).upcase.rjust(6, '0')} at index #{index}")
          break
        end
      end
      unless inserted
        result << new_item
        log("Appended #{new_item.to_s(16).upcase.rjust(6, '0')} at the end")
      end
    end
    as_hex_string_array result
  end

  def merge_sort
    as_hex_string_array merge_sort_impl(numeric_input)
  end

  alias default merge_sort

  def benchmark(array_size)
    puts "Benchmarking with array size: #{array_size}"
    sample_data = Array.new(array_size) { |i| rand(0x1000000) }
    Benchmark.ips do |x|
      x.report('postman') do
        @numeric_input = sample_data.dup
        postman
      end
      x.report('merge_sort') do
        @numeric_input = sample_data.dup
        merge_sort
      end
      x.compare!
    end
  end
end

if __FILE__ == $PROGRAM_NAME
  (puts "Usage: ruby #{$0} (csv-list) (algorithm)"; exit) unless ARGV.length > 0
  input = ARGV[0].split(',')
  algorithm = ARGV[1] || 'default'
  if algorithm == 'benchmark'
    HexStringSorter.new(input).benchmark(ARGV[2] ? ARGV[2].to_i : 1000)
  else
    puts "Using algorithm: #{algorithm}"
    calculator = HexStringSorter.new(input, true)
    puts "Input: #{calculator.input.inspect}"
    puts "Result: #{calculator.send(algorithm)}"
  end
end
