#!/usr/bin/env ruby

require 'benchmark/ips'

class OddSumCalculator
  attr_accessor :arr1, :arr2

  def initialize(arr1, arr2)
    self.arr1 = arr1
    self.arr2 = arr2
  end

  def chat_gpt_a
    result = []

    arr1.each do |a|
      arr2.each do |b|
        result << [a, b] if (a + b).odd?
      end
    end

    result.empty? ? nil : result
  end

  def chat_gpt_a_optimised
    # Partition arr1
    odds1, evens1 = arr1.partition(&:odd?)
    # Partition arr2
    odds2, evens2 = arr2.partition(&:odd?)

    result = []

    # Add pairs: odd from arr1 + even from arr2
    odds1.each do |a|
      evens2.each do |b|
        result << [a, b]
      end
    end

    # Add pairs: even from arr1 + odd from arr2
    evens1.each do |a|
      odds2.each do |b|
        result << [a, b]
      end
    end

    result.empty? ? nil : result
  end

  def deepseek_a
    evens1 = arr1.select(&:even?)
    odds1  = arr1.select(&:odd?)
    evens2 = arr2.select(&:even?)
    odds2  = arr2.select(&:odd?)

    pairs = []
    evens1.each { |e| odds2.each { |o| pairs << [e, o] } }
    odds1.each { |o| evens2.each { |e| pairs << [o, e] } }

    pairs.empty? ? nil : pairs
  end

  def andy_a
    a = arr1
    b = arr2
    results = []
    a.each do |x|
      b.each do |y|
        if ((x + y) % 2) == 1
          results << [x, y]
        end
      end
    end
    results
  end

  def andy_b
    a = arr1
    b = arr2
    (a.select(&:odd?).product(b.select(&:even?)) +
      b.select(&:odd?).product(a.select(&:even?)))
    .uniq
  end

  def andy_b_fixed
    a = arr1
    b = arr2
    (a.select(&:odd?).product(b.select(&:even?)) +
      a.select(&:even?).product(b.select(&:odd?)))
    .uniq
  end

  def andy_c
    a = arr1
    b = arr2
    a.product(b).select { (_1 + _2).odd? }.uniq
  end

  def andy_d
    a = arr1
    b = arr2
    odd_as, even_as = a.partition(&:odd?)
    odd_bs, even_bs = b.partition(&:odd?)
    (odd_as.product(even_bs) + odd_bs.product(even_as)).uniq
  end

  def andy_d_fixed
    a = arr1
    b = arr2
    odd_as, even_as = a.partition(&:odd?)
    odd_bs, even_bs = b.partition(&:odd?)
    (odd_as.product(even_bs) + even_as.product(odd_bs)).uniq
  end

  def examples_rule
    odds1, evens1 = arr1.partition(&:odd?)
    odds2, evens2 = arr2.partition(&:odd?)
    result = []

    evens2.sort!
    odds2.sort!

    odds1.each do |a|
      b = evens2.pop
      result << [a, b] if b
    end

    evens1.each do |a|
      b = odds2.pop
      result << [a, b] if b
    end

    result.empty? ? nil : result
  end

  def benchmark
    n = 100
    self.arr1 = Array.new(n) { |i| rand(1_000_000) }
    self.arr2 = Array.new(n) { |i| rand(1_000_000) }

    Benchmark.ips do |x|
      x.report('chatgpt_a') do
        chat_gpt_a
      end
      x.report('chat_gpt_a_optimised') do
        chat_gpt_a_optimised
      end
      x.report('deepseek_a') do
        deepseek_a
      end
      x.report('andy_d_fixed') do
        andy_d_fixed
      end
      x.compare!
    end
  end
end

if __FILE__==$PROGRAM_NAME
  (puts "Usage: ruby #{$0} <algorithm> (csv-array-1) (csv-array-1)"; exit) unless ARGV.length > 0
  algorithm = ARGV[0]
  if algorithm == 'benchmark'
    OddSumCalculator.new([], []).benchmark
  else
    arr1 = ARGV[1] ? ARGV[1].split(',').map(&:to_i) : [1, 2, 3]
    arr2 = ARGV[2] ? ARGV[2].split(',').map(&:to_i) : [4, 5, 6]
    puts "Using algorithm: #{algorithm}"
    calculator = OddSumCalculator.new(arr1, arr2)
    puts "Array 1: #{calculator.arr1.inspect}"
    puts "Array 2: #{calculator.arr2.inspect}"
    puts "Result: #{calculator.send(algorithm).inspect}"
  end
end
