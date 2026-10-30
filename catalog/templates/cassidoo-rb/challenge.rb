#!/usr/bin/env ruby

class Challenge
  attr_accessor :param1

  def initialize(param1)
    self.param1 = param1
  end

  def result
  end
end

if __FILE__ == $PROGRAM_NAME
  (warn "Usage: ruby #{$0} <param1>"; exit) unless ARGV.length == 1
  param1 = ARGV[0]
  calculator = Challenge.new(param1)
  warn "Param1: #{calculator.param1.inspect}"
  warn 'Result'
  puts calculator.result.inspect
end
