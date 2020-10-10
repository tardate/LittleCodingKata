#! /usr/bin/env ruby
require 'drb'

DRb.start_service()

client = DRbObject.new(nil, 'druby://localhost:9000')
puts client.doit
