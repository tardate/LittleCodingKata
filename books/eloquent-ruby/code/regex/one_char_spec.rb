#---
# Excerpted from "Eloquent Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/eruby2 for more book information.
#---
require "rspec"

RSpec.describe "One char matching" do
  it "has most normal characters matching themselves" do
    expect(/x/).to match('x')
    expect(/aaa/).to match('aaa')
    expect(/123/).to match('123')
    expect(/R2D2/).to match('R2D2')
    expect(/r2d2/).to_not match('R2D2')
  end

  it "has dot match any single char" do
    expect(/./).to match("r")
    expect(/./).to match("%")
    expect(/./).to match("~")

    expect(/../).to match("xx")
    expect(/../).to match("4F")
    expect(/../).to_not match("Q")
  end

  it "has bs turn off special meanings" do
    expect(/\./).to match(".")
    expect(/\./).to_not match("q")

    expect(/3\.14/).to match("3.14")
    expect(/3\.14/).to_not match("3714")
    expect(/Mr\. Anderson/).to match("Mr. Anderson")
    expect(/Mr\. Anderson/).to_not match("Mrx Anderson")
  end

  it "lets you mix and match" do
    expect(/A./).to match("AM")
    expect(/A./).to match("An")
    expect(/A./).to match("At")
    expect(/A./).to match("A=")

    expect(/...X/).to match("UVWX")
    expect(/...X/).to match("XOOX")

    expect(/...\. Smith/).to match("Prf. Smith")
    expect(/...\. Smith/).to match("Mrs. Smith")
    expect(/...\. Smith/).to_not match("Dr. Smith")
    expect(/...\. Smith/).to_not match("Lucy Smith")
  end
end
