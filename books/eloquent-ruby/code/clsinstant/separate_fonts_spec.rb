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
require_relative "resume"
require_relative "presentation"


describe Resume do
  it "acts like a document" do
    resume = Resume.new(title: "Russ O", author: "russ", content: "Hire me!")
    expect(resume.title).to eq("Russ O")
  end
end

describe Presentation do
  it "acts like a document" do
    resume = Presentation.new(title: "Buy More!", author: "russ", content: "Stuff")
    expect(resume.title).to eq("Buy More!")
  end
end

describe "Resume/Presentation independence" do
  it "means you can change the resume default font w/o affecting presentation" do
    Presentation.default_font = :arial
    Resume.default_font = :fixed
    expect(Presentation.default_font).to eq(:arial)
    expect(Resume.default_font).to eq(:fixed)
    Presentation.default_font = :times
    expect(Resume.default_font).to eq(:fixed)
  end
end
