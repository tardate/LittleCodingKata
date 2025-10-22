#! /usr/bin/env ruby

class AmateurSoloist
  @@instance = AmateurSoloist.new
  private_class_method :new

  def self.instance
    @@instance
  end

  def to_s
    "Amateur Soloist [object_id=#{object_id}]"
  end
end

if __FILE__==$PROGRAM_NAME
  (ARGV[0] || 2).to_i.times do |i|
    soloist = AmateurSoloist.instance
    puts "Instance #{i + 1}: #{soloist}"
  end
end
