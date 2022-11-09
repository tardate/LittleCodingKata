#! /usr/bin/env ruby
require 'netaddr'
require 'ipaddr'

class Ipv4Info
  attr_accessor :ip_address
  attr_accessor :ipaddr

  def initialize(ip_address)
    self.ip_address = ip_address
  end

  def net
    @net ||= NetAddr::IPv4Net.parse(ip_address)
  end

  def ipv4?
    net.version == 4
  end

  def private?
    IPAddr.new(net.to_s).private?
  end

  def cidr
    net.netmask.prefix_len
  end

  def netmask
    net.netmask.extended
  end

  def network_address
    net.network.to_s
  end

  def total_addresses
    net.len
  end

  def total_hosts
    [total_addresses - 2, 1].max
  end

  def info
    puts "Given: #{ip_address}, inspected using the NetAddr gem:\n\n"
    puts "               IPv4? : #{ipv4?}"
    puts "            Private? : #{private?}"
    puts "                CIDR : #{cidr}"
    puts "         Subnet mask : #{netmask}"
    puts "     Network address : #{network_address}"
    puts "Addresses in network : #{total_addresses}"
    puts "    Hosts in network : #{total_hosts}\n\n"
  end
end

if __FILE__==$PROGRAM_NAME
  (puts "Usage: ruby #{$0} <ipv4_address/cidr>"; exit) unless ARGV.length==1
  Ipv4Info.new(ARGV[0]).info
end
