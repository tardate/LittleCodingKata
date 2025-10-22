#! /usr/bin/env ruby

require 'singleton'

class ProSoloist
  include Singleton

  def to_s
    "Pro Soloist [object_id=#{object_id}]"
  end
end

if __FILE__==$PROGRAM_NAME
  (ARGV[0] || 2).to_i.times do |i|
    soloist = ProSoloist.instance
    puts "Instance #{i + 1}: #{soloist}"
  end
end
