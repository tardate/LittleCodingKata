#---
# Excerpted from "Eloquent Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/eruby2 for more book information.
#---
require "rspec"
require "nokogiri"

describe Nokogiri::XML::Builder do
  it "has a method_missing based interface" do
    expect do
      builder = Nokogiri::XML::Builder.new do |xml|
          xml.book {
            xml.title "Eloquent Ruby"
            xml.edition "2nd"
            xml.authors {
              xml.name "Russ Olsen"
            }
          }
      end

      puts builder.to_xml
    end.to output(/<book.*<title>.*<authors>.*Russ/m).to_stdout
  end

  it "lets you append _ and ! to the method" do
    expect do
      builder = Nokogiri::XML::Builder.new do |xml|
          xml.curriculum {
            xml.class_ "Intro to programming"
            xml.class_ "Ancient History"
            xml.class_ "Calculus I"
          }
      end

      puts builder.to_xml
    end.to output(/<class>Intro to.*<.class>/m).to_stdout
   end
end
