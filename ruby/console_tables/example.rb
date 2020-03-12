#! /usr/bin/env ruby
require 'tablesmith'

headers = [['Country', 'Books']]
data = [
  ['Australia',      28_234],
  ['Brazil',         57_473],
  ['China',          440_000],
  ['France',         77_986],
  ['Germany',        93_600],
  ['India',          90_000],
  ['Indonesia',      89_000],
  ['Italy',          61_966],
  ['Iran',           72_871],
  ['Japan',          139_078],
  ['Russia',         101_981],
  ['South Korea',    63_476],
  ['Spain',          44_000],
  ['Taiwan',         28_084],
  ['Turkey',         66_890],
  ['United Kingdom', 184_000],
  ['United States',  304_912]
]

puts 'Books Published/Year. Source: https://en.wikipedia.org/wiki/Books_published_per_country_per_year'

print (headers + data).to_table

puts "Sorted:"

print (headers + data.sort {|a, b| b.last <=> a.last}).to_table
