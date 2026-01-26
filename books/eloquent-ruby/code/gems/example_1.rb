#---
# Excerpted from "Eloquent Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/eruby2 for more book information.
#---
require_relative '../common/document'

  require "mp3info"
  
  Mp3Info.open("money.mp3") do |info|
    puts "title: #{info.tag.title}"
    puts "artist: #{info.tag.artist}"
    puts "album: #{info.tag.album}"
  end
