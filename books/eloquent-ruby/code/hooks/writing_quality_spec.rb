#---
# Excerpted from "Eloquent Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/eruby2 for more book information.
#---
require "rspec"

module WritingQuality
  def self.included(klass)
    puts "Hey, I've included in #{klass}"
  end

  def number_of_cliches
    # Body of method omitted
  end
end

describe "module inclused method" do
  it "fires when a class includes a module" do
    expect do
    class StudentEssay
      include WritingQuality
    end
    end.to output(/Hey.*inclu.*StudentEssay/).to_stdout
  end
end
