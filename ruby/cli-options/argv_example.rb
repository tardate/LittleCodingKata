#! /usr/bin/env ruby
# frozen_string_literal: true

p ['ARGV', ARGV]

ARGV.each do |arg|
  case arg
  when '--help', '-h'
    puts 'Help: This is a simple example of using ARGV to handle command-line options.'
    puts 'Usage: ruby argv_example.rb [options]'
    puts 'Options:'
    puts '  --help, -h     Show this help message'
    puts '  --version, -v  Show version information'
    exit
  when '--version', '-v'
    puts 'Version 1.0.0'
    exit
  else
    puts "Unknown option: #{arg}"
  end
end
