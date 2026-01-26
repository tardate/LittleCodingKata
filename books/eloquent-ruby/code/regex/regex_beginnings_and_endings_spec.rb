#---
# Excerpted from "Eloquent Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/eruby2 for more book information.
#---
require "rspec"
require_relative "regex_beginnings_and_endings"

RSpec.describe "Fairytale Regex Matching" do
  describe "#introduction" do
    it "matches a non-anchored 'Once upon a time' inside the string" do
      expect(introduction).to be true
    end
  end

  describe "#introduction_anchored" do
    it "only matches 'Once upon a time' at the beginning of the string" do
      expect(introduction_anchored).to be true
    end
  end

  describe "#ending" do
    it "matches only if the string ends with the correct sentence" do
      expect(ending).to be true
    end
  end

  describe "#multiline_fairytale" do
    it "matches beginning and end content across multiple lines" do
      expect(multiline_fairytale).to be true
    end
  end

  describe "#will_not_match_multiline" do
    it "fails to match due to lack of multiline flag" do
      expect(will_not_match_multiline).to be false
    end
  end

  describe "#will_match_multiline" do
    it "successfully matches across multiple lines with the multiline flag" do
      expect(will_match_multiline).to be true
    end
  end

  describe "#start_with_regex" do
    it "matches both start and end using regular expressions" do
      expect(start_with_regex).to be true
    end
  end

  describe "#start_and_end_with_string" do
    it "matches both start and end using string literals" do
      expect(start_and_end_with_string).to be true
    end
  end
end
