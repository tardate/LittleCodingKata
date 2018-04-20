#! /usr/bin/env ruby
#
require 'openssl'

def get_hmac_hexdigest(name, key, data)
  digest = OpenSSL::Digest.new(name)
  OpenSSL::HMAC.hexdigest(digest, key, data)
end

if __FILE__==$PROGRAM_NAME
  (puts "Usage: ruby #{$0} <digest_name> <key> <data>"; exit) unless ARGV.length==3
  puts get_hmac_hexdigest(ARGV[0], ARGV[1], ARGV[2])
end
