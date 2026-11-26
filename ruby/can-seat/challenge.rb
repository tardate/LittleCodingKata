#!/usr/bin/env ruby
require 'json'

def canSeat(guests, incompatible_pairs)
  tables = [[], []]
  incompatible_pairs.each do |guest_a, guest_b|
    guest_a_seated_at = tables[0].include?(guest_a) ? 0 : (tables[1].include?(guest_a) ? 1 : nil)
    guest_b_seated_at = tables[0].include?(guest_b) ? 0 : (tables[1].include?(guest_b) ? 1 : nil)
    if guest_a_seated_at.nil?
      if guest_b_seated_at.nil?
        tables[0] << guest_a
        tables[1] << guest_b
      else
        tables[guest_b_seated_at == 0 ? 1 : 0] << guest_a
      end
    else
      return false if guest_b_seated_at == guest_a_seated_at
      tables[guest_a_seated_at == 0 ? 1 : 0] << guest_b unless guest_b_seated_at
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
