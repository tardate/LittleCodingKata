#! /usr/bin/env ruby
require 'influxdb'
require './conf.rb'

influxdb = InfluxDB::Client.new host: HOST

puts "Creating database #{DATABASE}.."
influxdb.create_database(DATABASE)

puts "Adding user #{USERNAME}/#{PASSWORD}.."
influxdb.create_database_user(DATABASE, USERNAME, PASSWORD)
