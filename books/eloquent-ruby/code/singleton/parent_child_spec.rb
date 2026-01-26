#---
# Excerpted from "Eloquent Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/eruby2 for more book information.
#---
require "rspec"

class Parent
  def self.who_am_i
    puts "The value of self is #{self}"
  end
end

class Child < Parent
end

describe "value of self in class methods" do
  it "is always the object before the dot" do
    expect do
      Parent.who_am_i
    end.to output(/self is Parent/).to_stdout

    expect do
      Child.who_am_i
    end.to output(/self is Child/).to_stdout
      Parent.who_am_i
      Child.who_am_i
  end
end
