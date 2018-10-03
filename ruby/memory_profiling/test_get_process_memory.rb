#! /usr/bin/env ruby

require 'os'

os_rss_bytes = OS.rss_bytes / 1_000_000.0
ps_rss_bytes = `ps -o rss #{Process.pid}`.lines.last.to_i * 1024 / 1_000_000.0

puts "RSS according to OS.rss_bytes: #{os_rss_bytes} MB"
puts "RSS according to ps: #{ps_rss_bytes} MB"
