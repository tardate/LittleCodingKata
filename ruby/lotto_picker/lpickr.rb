#! /usr/bin/env ruby
#
require 'set'

def pick(number_count, upper_limit)
  raise 'Upper limit must be >= the number to pick' if number_count > upper_limit

  prng = Random.new

  choices = Set[]
  while choices.length < number_count do
    choices.add 1 + prng.rand(upper_limit)
  end
  choices.sort
end

if __FILE__==$PROGRAM_NAME
  if ARGV.length==2
    puts pick(ARGV[0].to_i, ARGV[1].to_i).join(', ')
  else
    puts <<~INSTRUCTIONS
      Usage: ruby #{$0} <number_to_pick> <max>
      e.g:

        ruby #{$0} 6 40
        5, 6, 14, 28, 30, 38

    INSTRUCTIONS
  end
end
