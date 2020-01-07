#! /usr/bin/env ruby
require 'influxdb'
require './conf.rb'

influxdb = InfluxDB::Client.new host: HOST, database: DATABASE, username: USERNAME, password: PASSWORD

puts "Querying the most recent #{SERIES}:core-0 stats from database:#{DATABASE}.."

influxdb.query(%(select * from #{SERIES} WHERE instance = 'core-0' ORDER BY time DESC LIMIT 6)).each do |result|
  puts result['values']
end