#!/usr/bin/env ruby

require 'benchmark/ips'

class Reorder
  attr_accessor :input, :sequence

  def initialize(input, sequence)
    self.input = input
    self.sequence = sequence
  end

  def non_mutating
    result = Array.new(input.length)
    sequence.each_with_index do |target_index, source_index|
      result[target_index] = input[source_index]
    end
    result
  end

  alias default non_mutating

  def mutating_simple
    positions = (0...input.size).to_a

    sequence.each_with_index do |target_index, source_index|
      current = positions.index(source_index)
      next if current == target_index

      value = input.delete_at(current)
      input.insert(target_index, value)

      moved = positions.delete_at(current)
      positions.insert(target_index, moved)
    end

    input
  end

  def mutating_cyclic
    (0...input.length).each do |source_index|
      while sequence[source_index] != source_index
        target_index = sequence[source_index]

        input[source_index], input[target_index] = input[target_index], input[source_index]
        sequence[source_index], sequence[target_index] = sequence[target_index], sequence[source_index]
      end
    end

    input
  end

  def benchmark
    puts "Benchmarking.."
    sample_input = ['C', 'D', 'E', 'F', 'G', 'H']
    sample_sequence = [3, 0, 4, 1, 2, 5]

    Benchmark.ips do |x|
      x.report('non_mutating') do
        @input = sample_input.dup
        @sequence = sample_sequence.dup
        non_mutating
      end
      x.report('mutating_simple') do
        @input = sample_input.dup
        @sequence = sample_sequence.dup
        mutating_simple
      end
      x.report('mutating_cyclic') do
        @input = sample_input.dup
        @sequence = sample_sequence.dup
        mutating_cyclic
      end
      x.compare!
    end
  end
end

if __FILE__ == $PROGRAM_NAME
  algorithm = ARGV[0]
  if algorithm == 'benchmark'
    Reorder.new([], []).benchmark
  else
    (puts "Usage: ruby #{$0} <algorithm> <csv strings> <csv sequence>"; exit) unless ARGV.length == 3
    input = ARGV[1].split(',').map(&:strip)
    sequence = ARGV[2].split(',').map(&:to_i)
    puts "Using algorithm: #{algorithm}"
    calculator = Reorder.new(input, sequence)
    puts "input: #{calculator.input.inspect}"
    puts "sequence: #{calculator.sequence.inspect}"
    puts "Result: #{calculator.send(algorithm).inspect}"
  end
end
