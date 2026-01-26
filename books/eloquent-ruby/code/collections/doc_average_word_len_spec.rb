#---
# Excerpted from "Eloquent Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/eruby2 for more book information.
#---
require "rspec"
require_relative "doc_average_word_len"

shared_examples "average_word_len" do |doc_class|
  let(:doc1) { doc_class.new(title: "Test", author: "Russ", content: "a b cccc") }
  let(:doc2) { doc_class.new(title: "Test", author: "Russ", content: "aa bb") }
  let(:doc3) { doc_class.new(title: "Test", author: "Russ", content: "aa aaaaaa") }
  let(:doc4) { doc_class.new(title: "Test", author: "Russ", content: "1234567") }

  it "computes the correct average word length" do
    expect(doc1.average_word_length).to be_within(0.001).of(2)
    expect(doc2.average_word_length).to be_within(0.001).of(2)
    expect(doc3.average_word_length).to be_within(0.001).of(4)
    expect(doc4.average_word_length).to be_within(0.001).of(7)
  end
end

describe AvgWordLenEach::Document do
    include_examples "average_word_len", AvgWordLenEach::Document
end

describe AvgWordLenReduce::Document do
    include_examples "average_word_len", AvgWordLenReduce::Document
end

describe AvgWordLenSumLong::Document do
    include_examples "average_word_len", AvgWordLenSumLong::Document
end

describe AvgWordLenSumShort::Document do
    include_examples "average_word_len", AvgWordLenSumLong::Document
end

describe AvgWordLenSumIt::Document do
    include_examples "average_word_len", AvgWordLenSumIt::Document
end

describe AvgWordLenSumUnderbar::Document do
    include_examples "average_word_len", AvgWordLenSumUnderbar::Document
end

describe AvgWordLenUltimate::Document do
    include_examples "average_word_len", AvgWordLenUltimate::Document
end
