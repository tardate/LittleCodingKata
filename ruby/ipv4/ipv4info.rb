#! /usr/bin/env ruby
require 'ipaddr'

class Ipv4Info
  attr_accessor :ip_address
  attr_accessor :net

  def initialize(ip_address)
    self.ip_address = ip_address
  end

  def net
    @net ||= IPAddr.new ip_address
  end

  def ipv4?
    net.ipv4?
  end

  def private?
    net.private?
  end

  def cidr
    net.prefix
  end

  def netmask
    IPAddr.new('255.255.255.255').mask(cidr).to_s
  end

  def network_address
    net.mask(cidr).to_s
  end

  def total_addresses
    2 ** (32 - cidr)
  end

  def total_hosts
    [total_addresses - 2, 1].max
  end

  def info
    puts "Given: #{ip_address}, inspected using the IPAddr stdib..\n\n"
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
