#!/usr/bin/env ruby

require 'rubyserial'

def usage
  puts "Usage: #{$PROGRAM_NAME} <serial_port> [command]"
  exit 1
end

port_spec = ARGV[0]
command = ARGV[1] || 'i'
usage if port_spec.nil? || port_spec.empty?

port_name,baud_rate = port_spec.split(':')
baud_rate = baud_rate.to_i
baud_rate = 115200 unless baud_rate > 0

socket = Serial.new(port_name, baud_rate, 8, :none, 1)

puts '# RubySerial demonstration'
puts "# client initialised for : #{port_name}"

socket.write "#{command}\r\n"

begin
  data = socket.gets
  puts data unless data.chomp.empty?
end until data.chomp.empty?

socket.close
