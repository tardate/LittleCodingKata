#---
# Excerpted from "Eloquent Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/eruby2 for more book information.
#---
require "rspec"

describe "Time arithmetic" do
  it "works one way but not the other" do
    now = Time.now

    one_minute_from_now = now + 60

    expect(one_minute_from_now).to be_a(Time)
    expect(one_minute_from_now > now).to be_truthy

    expect do
      one_minute_from_now = 60 + now    # Bang!
    end.to raise_error(TypeError)
  end
end

describe "String % operator" do
  it "formats like printf" do
    expect(
      "The value of n is %d" % 42
    ).to match(/The.*n is 42/)
  end

  it "lets you format multiple values" do
    day = 4
    month = 7
    year = 1776

    file_name = "file_%02d%02d%d" % [ day, month, year ]
    expect(file_name).to eq("file_04071776")

    file_name = sprintf("file_%02d%02d%d", day, month, year )
    expect(file_name).to eq("file_04071776")
  end
end

describe "Set [] constructor" do
  it "gives you an alternative way to create sets" do
    s1 = Set.new([1, 2, 3])

    s2 = Set[1, 2, 3]

    expect(s1).to eq(s2)
    expect(s2.size).to eq(3)
  end
end
