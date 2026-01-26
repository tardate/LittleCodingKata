#---
# Excerpted from "Eloquent Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/eruby2 for more book information.
#---
trace = TracePoint.new do |tp|
  puts "#{tp.event} in #{tp.path}/#{tp.lineno} #{tp.method_id}"
end

trace.enable do
  load "simple_example.rb"
end
