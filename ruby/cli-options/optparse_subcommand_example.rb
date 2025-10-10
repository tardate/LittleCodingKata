#! /usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'

global_parser = OptionParser.new do |parser|
  parser.banner = "#{$0} [global options] command [command options] [command args...]"
  parser.on("--verbose", "Show additional logging/debug information")
end

commands = {}
commands["audit"] = OptionParser.new do |parser|
  parser.banner = "#{$0} [global options] audit [command options] [command args...]"
  parser.on("--type TYPE", "Set the type of test to audit. Omit to audit all types")
end

global_options  = {}
command_options = {}

global_parser.order!(into: global_options)
command = ARGV.shift
command_parser = commands[command]
command_parser&.parse!(into: command_options)

puts "global_options: #{global_options.inspect}"
puts "command: #{command}"
puts "command_options: #{command_options.inspect}"
puts "ARGV: #{ARGV.inspect}"
