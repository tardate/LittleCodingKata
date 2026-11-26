#!/usr/bin/env ruby
require 'json'

def canSeat(guests, incompatible_pairs)
  table1 = []
  table2 = []
  incompatible_pairs.each do |guest_a, guest_b|
    if !table1.include?(guest_a) && !table2.include?(guest_a)
      # if guest_a is not already seated, try to seat based on where guest_b may already be seated
      if table1.include?(guest_b)
        table2 << guest_a
      elsif table2.include?(guest_b)
        table1 << guest_a
      else
        table1 << guest_a
        table2 << guest_b
      end
    else
      # guest_a is already seated, so must seat guest_b at the other table
      if table1.include?(guest_a) && !table1.include?(guest_b)
        table2 << guest_b unless table2.include?(guest_b)
      elsif table2.include?(guest_a) && !table2.include?(guest_b)
        table1 << guest_b unless table1.include?(guest_b)
      else
        # oops, we can't seat both guests at different tables
        return false
      end
    end
  end
  true
end

if __FILE__ == $PROGRAM_NAME
  (warn "Usage: ruby #{$0} <guests> <incompatible_pairs>"; exit) unless ARGV.length == 2
  guests = JSON.parse(ARGV[0])
  incompatible_pairs = JSON.parse(ARGV[1])
  warn "Guests: #{guests.inspect}"
  warn "Incompatible Pairs: #{incompatible_pairs.inspect}"
  warn 'Result:'
  puts canSeat(guests, incompatible_pairs)
end
