#---
# Excerpted from "Eloquent Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/eruby2 for more book information.
#---
require "rspec"
require_relative "prose_rating"

shared_examples "prose_rating" do |doc_class|
  let(:doc) {doc_class.new(author: "russ", title: "test", content: "")}

  it "correctly identifies really pretentious prose" do
    expect(doc).to receive(:pretentious_density).at_least(1).times.and_return(0.5)
    expect(doc).to receive(:informal_density).at_least(1).times.and_return(0.1)
    expect(doc.prose_rating).to eq(:really_pretentious)
  end

  it "correctly identifies somewhat pretentious prose" do
    expect(doc).to receive(:pretentious_density).at_least(1).times.and_return(0.5)
    expect(doc).to receive(:informal_density).at_least(1).times.and_return(0.5)
    expect(doc.prose_rating).to eq(:somewhat_pretentious)
  end

  it "correctly identifies really informal prose" do
    expect(doc).to receive(:pretentious_density).at_least(1).times.and_return(0.001)
    expect(doc).to receive(:informal_density).at_least(1).times.and_return(0.9)
    expect(doc.prose_rating).to eq(:really_informal)
  end

  it "correctly identifies somewhat informal prose" do
    expect(doc).to receive(:pretentious_density).at_least(1).times.and_return(0.001)
    expect(doc).to receive(:informal_density).at_least(1).times.and_return(0.1)
    expect(doc.prose_rating).to eq(:somewhat_informal)
  end

  it "correctly identifies good prose" do
    expect(doc).to receive(:pretentious_density).at_least(1).times.and_return(0.2)
    expect(doc.prose_rating).to eq(:about_right)
  end
end

module Decent 
  describe Document do
    include_examples "prose_rating", Document
  end
end

module Better
  describe Document do
    include_examples "prose_rating", Document
  end
end

module Best
  describe Document do
    include_examples "prose_rating", Document
  end
end
