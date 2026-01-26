#---
# Excerpted from "Eloquent Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/eruby2 for more book information.
#---
require "rspec"
require_relative "combined"
require_relative "spec_utils"

describe "Combined rawk example" do
  before(:each) { create_marketing_documents }
  after(:each)  { delete_marketing_documents }

  it "allows combined rawk script to print paths" do
    expect do
      Version1.run_combined_rawk
    end.to output(/mark.*mark.*broch/m).to_stdout
  end

  it "allows combined rawk scripts to print first lines" do
    expect do
      Version1.run_combined_rawk
    end.to output(/title:/).to_stdout
  end

  it "allows combined rawk scripts to transform text" do
    Version1.run_combined_rawk
    expect(File.read("marketing/brochure.txt")).to match(/Coswell Cogs/)
  end
end
