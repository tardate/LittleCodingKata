#!/usr/bin/env ruby

def split_by_widths(input, widths)
  result = []
  index = 0
  while index < input.length do
    width = widths.shift || width
    result << input[index, width]
    index += width
  end
  result
end

if __FILE__ == $PROGRAM_NAME
  (puts "Usage: ruby #{$0} (string) (widths comma separated)"; exit) unless ARGV.length > 1
  input = ARGV[0]
  widths = ARGV[1].split(',').map(&:to_i)
  puts split_by_widths(input, widths).inspect
end
