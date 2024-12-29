#!/usr/bin/env ruby

require 'csv'

def csv_to_markdown(file)
  table = CSV.read(file)
  markdown = ""
  markdown << "| " + table[0].join(" | ") + " |\n"
  markdown << "|" + (" --- |" * table[0].size) + "\n"
  table[1..-1].each do |row|
    markdown << "| " + row.join(" | ") + " |\n"
  end
  markdown
end

if __FILE__==$PROGRAM_NAME
  (puts "Usage: ruby #{$0} <csv_file>"; exit) unless ARGV.length==1
  puts csv_to_markdown(ARGV[0])
end
