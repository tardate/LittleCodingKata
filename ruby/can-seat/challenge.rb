#!/usr/bin/env ruby
require 'json'

def canSeat(guests, incompatible_pairs)
  guest_seating = {}
  incompatible_pairs.each do |guest_a, guest_b|
    if guest_seating[guest_a].nil?
      if guest_seating[guest_b].nil?
        guest_seating[guest_a] = 0
        guest_seating[guest_b] = 1
      else
        guest_seating[guest_b] = 1 - guest_seating[guest_a]
      end
    else
      return false if guest_seating[guest_a] == guest_seating[guest_b]

      guest_seating[guest_b] = 1 - guest_seating[guest_a]
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
