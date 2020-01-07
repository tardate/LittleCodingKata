#! /usr/bin/env ruby
require 'influxdb'
require './conf.rb'

time_precision = 's'

influxdb = InfluxDB::Client.new host: HOST, database: DATABASE, username: USERNAME, password: PASSWORD

puts "Streaming some stats to database:${DATABASE} every 5 seconds.."

loop do
  stats = `w | head -1`.chomp
  timestamp = InfluxDB.now(time_precision)
  load_averages = stats.split('averages:').last.split(' ').collect(&:to_f)
  data = load_averages.each_with_index.map do |load, i|
    {
      series: SERIES,
      tags: { instance: "core-#{i}" },
      values: { load: load },
      timestamp: timestamp
    }
  end
  puts "Posting #{load_averages} at #{timestamp}.."
  influxdb.write_points data, time_precision

  sleep 5
end
