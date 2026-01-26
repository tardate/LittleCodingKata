#---
# Excerpted from "Eloquent Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/eruby2 for more book information.
#---
require "rspec"
require_relative "must_happen.rb"

describe "log_before" do
  it "logs then executes the block" do
    expect do
      MustHappen.log_before("log msg") { puts "do it" }
    end.to output(/log msg.*do it/m).to_stdout
  end
end

describe "log_after" do
  it "executes the block then logs" do
    expect do
      MustHappen.log_after("log msg") { puts "do it" }
    end.to output(/do it.*log msg/m).to_stdout
  end
end
