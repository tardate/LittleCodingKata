#!/usr/bin/env ruby

def halloweenSwap(costumes)
  swaps = 0
  (0...costumes.length).each do |i|
    next if costumes[i] == i

    # Find the person who owns the costume that person i is wearing
    j = costumes.index(i)

    # Swap the costumes
    costumes[i], costumes[j] = costumes[j], costumes[i]
    swaps += 1
  end
  swaps
end

if __FILE__ == $PROGRAM_NAME
  (warn "Usage: ruby #{$0} <costumes-array>"; exit) unless ARGV.length == 1
  costumes = ARGV[0].split(',').map(&:to_i)
  warn "Costumes: #{costumes.inspect}"
  warn 'Result:'
  puts halloweenSwap(costumes)
end
