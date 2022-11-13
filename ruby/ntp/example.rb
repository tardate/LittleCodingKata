#! /usr/bin/env ruby
require 'net/ntp'

class NetTime
  attr_accessor :server
  def initialize(server)
    self.server = server || 'us.pool.ntp.org'
  end

  def response
    @response ||= Net::NTP.get server
  end

  def time
    response.time
  end

  def print_info
    puts "Time is: #{response.time}\n\n"
    puts "NTP response details:"
    puts "host: #{server}"
    puts "mode: #{response.mode_text}"
    puts "version: #{response.version_number}"
    puts "leap_indicator: #{response.leap_indicator_text}"
    puts "poll_interval: #{response.poll_interval}"
    puts "precision: #{response.precision}"
    puts "root_delay: #{response.root_delay}"
    puts "root_dispersion: #{response.root_dispersion}"
    puts "reference_timestamp: #{response.reference_timestamp}"
    puts "originate_timestamp: #{response.originate_timestamp}"
    puts "receive_timestamp: #{response.receive_timestamp}"
    puts "transmit_timestamp: #{response.transmit_timestamp}"
    puts "offset: #{response.offset}"
    puts "stratum: #{response.stratum} - #{response.stratum_text}"
    puts "reference_clock_identifier: #{response.reference_clock_identifier}"
    puts "reference_clock_identifier_text: #{response.reference_clock_identifier_text}"
  end
end

if __FILE__==$PROGRAM_NAME
  NetTime.new(ARGV.first).print_info
end
