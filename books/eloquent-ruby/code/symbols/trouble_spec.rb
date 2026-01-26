#---
# Excerpted from "Eloquent Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/eruby2 for more book information.
#---
require "rspec"
require_relative "../common/document"

describe Symbol do
  it "lets you turn symbols into strings" do
    the_string = :percentage.to_s
    expect(the_string).to eq("percentage")
  end

  it "lets you turn strings into symbols" do
    the_symbol = "percentage".to_sym
    expect(the_symbol).to eq(:percentage)
  end

  it "does not like it when you mix up symbols with strings" do
    expect do
      # Some broken code
      person = {} 
      person[:name] = "russ"
      person[:eyes] = "misty blue"

      # A little later...
      puts "Name: #{person["name"]} Eyes: #{person["eyes"]}"
    end.to output(/Name: *Eyes: *\n/m).to_stdout

    expect do
      person = {} 
      person[:name] = "russ"
      person[:eyes] = "misty blue"

      puts "Name: #{person[:name]} Eyes: #{person[:eyes]}"
    end.to output(/Name.*russ.*blue/).to_stdout
  end
end
