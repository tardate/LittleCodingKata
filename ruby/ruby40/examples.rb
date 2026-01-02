#!/usr/bin/env ruby
# frozen_string_literal: true

def demo_fluent_logical_binary_operators
  puts "## Demo: Logical binary operators"
  puts "In Ruby 4.0, Logical binary operators (`||`, `&&`, `and` and `or`) at the beginning of a line continue the previous line, like fluent dot."
  condition1 = true
  condition2 = true
  puts <<-END_EXAMPLE
  Example:
    if condition1
      && condition2
      puts "OK!"
    end
  END_EXAMPLE
  if condition1
    && condition2
    puts "OK!"
  end
end

def demo_infinite_enumerator_produce
  puts "## Demo: Infinite enumerator"
  puts "In Ruby 4.0, `Enumerator.produce` now accepts an optional size keyword argument to specify the size of the enumerator"
  puts <<-END_EXAMPLE
  Example:
    Enumerator.produce(1, size: Float::INFINITY, &:succ).size == Float::INFINITY
  END_EXAMPLE
  puts Enumerator.produce(1, size: Float::INFINITY, &:succ).size
end

def demo_finite_enumerator_produce
  puts "## Demo: Finite enumerator with known/computable size"
  puts "Example:"
  puts <<-END_EXAMPLE
    required_items = 4
    traverser = Enumerator.produce(0, size: required_items) do |it|
      raise StopIteration if it == required_items - 1
      it + 1
    end
    traverser.each { |n| puts n }
  END_EXAMPLE
  required_items = 4
  traverser = Enumerator.produce(0, size: required_items) do |it|
    raise StopIteration if it == required_items - 1
    it + 1
  end
  puts "traverser.size: #{traverser.size}"
  traverser.each { |n| puts n }
end

def demo_pathname
  puts "## Demo: Pathname"
  puts "In Ruby 4.0, `Pathname` has been promoted from a default gem to a core class of Ruby"
  puts <<-END_EXAMPLE
  Example:
    puts Pathname.new("../ruby40").basename
  END_EXAMPLE
  puts Pathname.new("../ruby40").basename
end

demo_fluent_logical_binary_operators
demo_infinite_enumerator_produce
demo_finite_enumerator_produce
demo_pathname
