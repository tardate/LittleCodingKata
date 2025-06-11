#!/usr/bin/env ruby

require 'serialport'

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

socket = SerialPort.new(port_name, 'baud' => baud_rate, 'data_bits' => 8, 'stop_bits' => 1, 'parity' => SerialPort::NONE)
socket.timeout = 1

puts "# SerialPort demonstration"
puts "# client initialised for : #{port_name}"
puts "#     connection options : #{socket.modem_params.inspect}"
puts "#                signals : #{socket.signals.inspect}"

socket.write "#{command}\r\n"

begin
  data = socket.gets
  puts data unless data.chomp.empty?
end until data.chomp.empty?

socket.close
