#! /usr/bin/env ruby
require 'influxdb2/client'
require './conf.rb'

time_precision = 's'
series_tags = %w[past1 past5 past15]
format = if ARGV.length > 0
  ARGV[0]
end
format ||= :line

influxdb = InfluxDB2::Client.new(HOST, TOKEN, bucket: BUCKET, org: ORG, precision: InfluxDB2::WritePrecision::NANOSECOND, use_ssl: false)
write_api = influxdb.create_write_api

puts "Streaming some stats to bucket:#{BUCKET} every 5 seconds.."

loop do
  stats = `w | head -1`.chomp
  timestamp = Time.now.to_i * 1_000_000_000
  load_averages = stats.split('averages:').last.split(' ').collect(&:to_f)
  data = load_averages.each_with_index.map do |load, i|
    case format.to_sym
    when :hash
      {
        name: MEASUREMENT,
        tags: { series: series_tags[i] },
        fields: { utilization: load },
        time: timestamp
      }
    when :point
      InfluxDB2::Point.new(name: MEASUREMENT)
        .add_tag('series', series_tags[i])
        .add_field('utilization', load)
        .time(timestamp, InfluxDB2::WritePrecision::NANOSECOND)
    when :line
      %{#{MEASUREMENT},series=#{series_tags[i]} utilization=#{load} #{timestamp}}
    end
  end
  puts "Posting #{load_averages} at #{timestamp}.."
  puts data.inspect
  write_api.write data: data

  sleep 5
end
