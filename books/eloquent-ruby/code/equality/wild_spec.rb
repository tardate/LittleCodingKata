#---
# Excerpted from "Eloquent Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/eruby2 for more book information.
#---
require "rspec"

describe Integer do
  it "believes that some integers are equal to some floating point numbers" do
    expect do
      puts 1 == 1.0     # An Integer and a Float
    end.to output(/true/).to_stdout
  end

  it "implements natural ordering with <=>" do
    a = 1
    b = 2

    expect(
      a <=> b
    ).to eq(-1)

    expect(b <=> a).to eq(1)
    expect(b <=> 2).to eq(0)
  end
end

describe Class do
  it "implements === as kind_of?" do
    expect do
      the_object = 3.14159

      case the_object
      when String
        puts "it's a string"
      when Float
        puts "It's a float"
      when Integer
        puts "It's an integer"
      else
        puts "Dunno!"
      end
    end.to output(/a float/).to_stdout
  end
end
