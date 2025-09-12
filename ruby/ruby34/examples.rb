#!/usr/bin/env ruby
# frozen_string_literal: true

def demo_frozen_string_literal
  puts "## Demo: Frozen String Literal"
  puts "In Ruby 3.4, all string literals are frozen by default."
  puts "Example:"
  str = "Hello"
  puts "str = #{str.inspect}; str.frozen? => #{str.frozen?}"
  puts "Attempting to modify the string will raise an error:"
  begin
    str << " World"
  rescue => e
    puts "Error: #{e.message}"
  end
end

def demo_default_block_parameter
  puts "## Demo: Default Block Parameter"
  puts "In Ruby 3.4, you can use 'it' as a default block parameter."
  puts "Example: [1, 2, 3].each { puts it }"
  [1, 2, 3].each { puts it }
  puts "This simplifies numbered parameters introduced in Ruby 2.7: [1, 2, 3].each { puts _1 }"
  [1, 2, 3].each { puts _1 }
end

def demo_array_fetch_values
  puts "## Demo: Array#fetch_values"
  puts "In Ruby 3.4, Array#fetch_values was added to fetch multiple values by index."
  arr = ['a', 'b', 'c', 'd', 'e']
  puts "Array: #{arr.inspect}"
  puts "Fetching values at indices 1, 3, and 4:"
  values = arr.fetch_values(1, 3, 4)
  puts "Fetched values: #{values.inspect}"
end

def demo_keyword_splatting_nil
  puts "## Demo: Keyword Splatting Nil"
  puts "In Ruby 3.4, splatting nil into keyword arguments is allowed."
  def example_method(**kwargs)
    puts "Received keyword arguments: #{kwargs}"
  end
  puts "Calling example_method(**nil) will not raise an error in Ruby 3.4:"
  example_method(**nil)
end

def demo_hash_new_capacity
  puts "## Demo: Hash.new with Capacity"
  puts "In Ruby 3.4, you can create a hash with a specified initial capacity."
  puts "Example: hash = Hash.new(capacity: 10)"
  hash = Hash.new(capacity: 10)
  puts "Created hash with capacity: #{hash.inspect}"
end

def demo_range_size_on_not_iterable_range
  puts "## Demo: Range Size on Non-Iterable Range"
  puts "In Ruby 3.4, calling size on a range with non-iterable endpoints raises a TypeError."
  begin
    puts "Example (0.51..1.0).size"
    puts (0.51..1.0).size
  rescue TypeError => e
    puts "Error: #{e.message}"
  end
end

demo_frozen_string_literal
demo_default_block_parameter
demo_array_fetch_values
demo_keyword_splatting_nil
demo_hash_new_capacity
demo_range_size_on_not_iterable_range
