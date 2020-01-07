#! /usr/bin/env ruby
require 'influxdb'
require './conf.rb'

influxdb = InfluxDB::Client.new host: HOST, username: USERNAME, password: PASSWORD

puts "List databases.."
puts influxdb.list_databases

