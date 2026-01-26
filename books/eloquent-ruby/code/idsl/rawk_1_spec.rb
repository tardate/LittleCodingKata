#---
# Excerpted from "Eloquent Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/eruby2 for more book information.
#---
require "rspec"
require_relative "rawk_1"
require_relative "spec_utils"

module Version1
  def self.run_combined
    rawk = Rawk.new do |r|
      r.on_path("*.txt") { |path| puts path }

      r.on_file("*.txt") do |path|
        open(path) { |f| puts f.readline }
      end

      r.transform("*.txt") do |contents|
        contents.gsub!(/Spacely Sprockets/, "Coswell Cogs")
      end
    end

    rawk.run("marketing")
  end
end

module Version1
  describe Rawk do
    before(:each) { create_marketing_documents }
    after(:each)  { delete_marketing_documents }

    it "can print paths" do
      expect do
        rawk = Rawk.new do |r|
          r.on_path("*.txt") { |path| puts path }
        end
        rawk.run("marketing")
      end.to output(/mark.*mark.*broch/m).to_stdout
    end

    it "allows combined rawk script to print paths" do
      expect { Version1.run_combined }.to output(/mark.*broch/).to_stdout
      expect { Version1.run_combined }.to output(/mark.*ad_copy/).to_stdout
    end

    it "allows combined rawk scripts to print first lines" do
      expect do
        Version1.run_combined
      end.to output(/title:/).to_stdout
    end

    it "allows combined rawk scripts to transform text" do
      Version1.run_combined
      expect(File.read("marketing/brochure.txt")).to match(/Coswell/)
    end

    it "can find any path" do
      matched = []
      rawk = Rawk.new do |r|
        r.on_path { |path| matched << path }
      end
      rawk.run("example")

      pp matched
      expect(matched.size).to eq(6)
      expect(matched).to include("example")
      expect(matched).to include("example/first.txt")
      expect(matched).to include("example/second.txt")
      expect(matched).to include("example/subdir")
      expect(matched).to include("example/subdir/sub_first.txt")
      expect(matched).to include("example/subdir/sub_second.txt")
    end

    it "can find files" do
      matched = []
      rawk = Rawk.new do |r|
        r.on_file { |path| matched << path }
      end
      rawk.run("example")

      expect(matched.size).to eq(4)
      expect(matched).to include("example/first.txt")
      expect(matched).to include("example/second.txt")
      expect(matched).to include("example/subdir/sub_first.txt")
      expect(matched).to include("example/subdir/sub_second.txt")
    end

    it "can find specific files" do
      matched = []
      rawk = Rawk.new do |r|
        r.on_file("*/sub*txt") { |path| matched << path }
      end
      rawk.run("example")

      expect(matched.size).to eq(2)
      expect(matched).to include("example/subdir/sub_first.txt")
      expect(matched).to include("example/subdir/sub_second.txt")
    end

    it "can find directories" do
      matched = []
      rawk = Rawk.new do |r|
        r.on_dir { |path| matched << path }
      end
      rawk.run("example")

      expect(matched.size).to eq(2)
      expect(matched).to include("example")
      expect(matched).to include("example/subdir")
    end
  end
end
