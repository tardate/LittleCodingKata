#---
# Excerpted from "Eloquent Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/eruby2 for more book information.
#---
require_relative "regex_time"

RSpec.describe "Time Regex Methods" do
  describe "#time_regex" do
    it "matches valid time format with AM/PM" do
      expect(time_regex).to match("10:24 AM")
      expect(time_regex).to match("01:00 PM")
    end

    it "does not match invalid time format" do
      expect(time_regex).not_to match("10:24 NM")
      expect(time_regex).not_to match("10:24")
      expect(time_regex).not_to match("1024 AM")
    end
  end

  describe "#time_match" do
    it "returns true for valid time string" do
      expect(time_match).to be true
    end
  end

  describe "#non_match" do
    it "returns false for invalid time string" do
      expect(non_match).to be false
    end
  end

  describe "#anywhere_match" do
    it "returns true for matching substring within a larger string" do
      expect(anywhere_match).to be true
    end
  end

  describe "#anywhere_match_flipped" do
    it "also returns true for matching substring using flipped syntax" do
      expect(anywhere_match_flipped).to be true
    end
  end

  describe "#case_insensitive_match" do
    it "returns true for case-insensitive match of 'am' and /AM/i" do
      expect(case_insensitive_match).to be true
    end
  end
end
