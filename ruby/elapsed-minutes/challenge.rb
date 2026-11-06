#!/usr/bin/env ruby
require 'time'

def to_minutes(timestamp)
  hours, minutes = timestamp.split(':').map(&:to_i)
  hours * 60 + minutes
end

class Challenge
  attr_accessor :timestamps

  def initialize(timestamps)
    self.timestamps = timestamps
  end

  def using_time_class
    t1 = Time.strptime(timestamps.first, "%H:%M").to_i
    t2 = Time.strptime(timestamps.last, "%H:%M").to_i
    (t2 - t1) / 60 + 60
  end

  def raw
    t1 = to_minutes(timestamps.first)
    t2 = to_minutes(timestamps.last)
    t2 - t1 + 60
  end

  alias default raw
end

if __FILE__ == $PROGRAM_NAME
  (warn "Usage: ruby #{$0} <timestamps-csv> <algorithm>"; exit) unless ARGV.length == 1 || ARGV.length == 2
  timestamps = ARGV[0].split(',').map(&:strip)
  algorithm = ARGV[1] || 'default'
  warn "Using algorithm: #{algorithm}"
  calculator = Challenge.new(timestamps)
  warn "Timestamps: #{calculator.timestamps.inspect}"
  warn 'Result:'
  puts calculator.send(algorithm).inspect
end
