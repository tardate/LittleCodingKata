str = "This is a test. "
str.freeze
begin
  str << " Don’t be alarmed."   # Attempting to modify
rescue => err
  puts "#{err.class} #{err}"
end

arr = [1, 2, 3]

arr.freeze
begin
  arr << 4                      # Attempting to modify
rescue => err
  puts "#{err.class} #{err}"
end


# Output:
#   TypeError: can’t modify frozen string
#   TypeError: can’t modify frozen array
