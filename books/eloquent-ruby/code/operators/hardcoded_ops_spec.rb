#---
# Excerpted from "Eloquent Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/eruby2 for more book information.
#---
require "rspec"

class Thing
  attr_reader :value

  def initialize(value)
    @value = value
  end

  def !
    return Thing.new(-@value)
  end

  def |(other)
    return Thing.new(@value + other.value)
  end
end


describe "Ruby treatment of not and !" do
  it "lets you override !" do
    t = Thing.new(10)
    nt = !t
    expect(nt).to be_a(Thing)
    expect(nt.value).to eq(-10)
  end

  it "locks not to !" do
    t = Thing.new(10)
    not_t = (not t)
    expect(not_t).to be_a(Thing)
    expect(not_t.value).to eq(-10)
  end

  it "does something with or" do
    t = Thing.new(10)
    not_t = (not t)
    expect(not_t).to be_a(Thing)
    expect(not_t.value).to eq(-10)
  end

  it "lets you override |" do
    t1 = Thing.new(10)
    t2 = Thing.new(20)
    t3 = t1 | t2
    expect(t3).to be_a(Thing)
    expect(t3.value).to eq(30)
    t3 = t2 | t1
    expect(t3).to be_a(Thing)
    expect(t3.value).to eq(30)
  end

  it "or operator is hardwired" do
    t1 = Thing.new(10)
    t2 = Thing.new(20)
    result = t1 or t2
    expect(result).to be(t1)
    result = t2 or t1
    expect(result).to be(t2)
    result = t1 or nil
    expect(result).to be(t1)
  end
end
