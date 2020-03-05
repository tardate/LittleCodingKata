#! /usr/bin/env ruby
require 'influxdb2/client'
require './conf.rb'

require 'time' # not required with influxdb2 > 1.1.0

influxdb = InfluxDB2::Client.new(HOST, TOKEN, org: ORG, use_ssl: false)

puts "Querying the most recent #{MEASUREMENT} stats from bucket:#{BUCKET}.."
query_api = influxdb.create_query_api

results = query_api.query(query: %{
  from(bucket:"#{BUCKET}") |> range(start: 1970-01-01T00:00:00.000000001Z) |> last() |> filter(fn: (r) => r._measurement == "#{MEASUREMENT}")
})

results.each do |result|
  puts "\nRecord: #{result.first}"
  result.last.columns.each do |column|
    puts column.inspect
  end
  result.last.records.each do |record|
    puts record.inspect
  end
end
