#---
# Excerpted from "Eloquent Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/eruby2 for more book information.
#---
require "rspec"
require "find"
require_relative "spec_utils"

describe "File.fnmatch" do
  it "does glob style matching" do
    expect(
      File.fnmatch("*.txt", "resume.txt")                    # True!
    ).to be_truthy

    expect(
      File.fnmatch("*.txt", "book.doc")                      # False!
    ).to be_falsey
  end
end

describe "the combination of Find and fnmatch" do
  before(:each) { create_marketing_documents }
  after(:each)  { delete_marketing_documents }

  it "calls a block for each path" do
    expect do
      # Call the block with every file and directory starting at marketing.
      Find.find("marketing") do |path|
        puts path
      end
    end.to output(/mark.*mark.*.brochure.txt/m).to_stdout
  end

  it "prints the first line of each txt file" do
    expect do
      Find.find("marketing") do |path|
        next unless File.fnmatch("*.txt", path)
        open(path) { |f| puts f.readline }
      end
    end.to output(/title: Spacely/).to_stdout
  end

  it "replaces a string in all the txt files" do
      Find.find("marketing") do |path|
        next unless File.fnmatch("*.txt", path)
        contents = File.read(path)
        contents.gsub!(/Spacely Sprockets/, "Coswell Cogs")
        open(path, "w") { |f| f.write(contents) }
      end

      contents = File.read("marketing/brochure.txt")
      expect(contents).to match(/Coswell/)
  end
end

