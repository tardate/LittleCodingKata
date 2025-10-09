#! /usr/bin/env ruby
# frozen_string_literal: true

require 'getoptlong'

options = GetoptLong.new(
  ['--help', '-h', GetoptLong::NO_ARGUMENT],
  ['--verbose', '-v', GetoptLong::NO_ARGUMENT],
  ['--output', '-o', GetoptLong::REQUIRED_ARGUMENT]
)
options.each do |option, arg|
  case option
  when '--verbose'
    puts "Verbose mode enabled."
  when '--output'
    puts "Output file: #{arg}"
  when '--help'
    puts "Usage: script.rb [options]"
    puts "--help, -h          Show this help message"
    puts "--verbose, -v       Enable verbose mode"
    puts "--output, -o FILE   Specify output file"
  end
end
