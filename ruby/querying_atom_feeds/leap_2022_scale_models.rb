#! /usr/bin/env ruby
require 'nokogiri'
require 'open-uri'

source = 'https://leap.tardate.com/catalog/atom.xml'
target_term = 'scale models'
target_year = 2022

feed = Nokogiri::XML(URI.open(source))
projects = feed.xpath(%(//xmlns:entry[xmlns:category[@term="#{target_term}"]][starts-with(xmlns:updated, "#{target_year}-")]))

puts "Found #{projects.size} projects updated in #{target_year} tagged with '#{target_term}'"
projects.each do |project|
  puts project.at('title').content
end
