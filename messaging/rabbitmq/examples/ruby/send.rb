#!/usr/bin/env ruby
require 'bunny'

connection = Bunny.new(automatically_recover: false)
connection.start

channel = connection.create_channel
queue = channel.queue('hello')

message = "Hello World! #{Time.now}"
channel.default_exchange.publish(message, routing_key: queue.name)
puts " [√] Sent message:'#{message}' on queue:#{queue.name}"

connection.close
