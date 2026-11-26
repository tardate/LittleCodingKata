#! /usr/bin/env ruby
require 'toml-rb'
require 'pp'

def load_and_parse_toml_file(filename)
  parsed = TomlRB.load_file(filename)
  warn "\n## Parsed TOML from #{filename}:"
  warn parsed.pretty_inspect
  parsed
end

def dump_to_toml(parsed)
  dumped = TomlRB.dump(parsed)
  warn "\n## Dumped back to TOML:"
  warn dumped
  dumped
end

if __FILE__ == $PROGRAM_NAME
  (warn "Usage: ruby #{$0} <filename>"; exit) unless ARGV.length == 1
  filename = ARGV[0]
  dump_to_toml load_and_parse_toml_file filename
end
