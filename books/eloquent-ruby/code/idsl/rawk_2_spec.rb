#---
# Excerpted from "Eloquent Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/eruby2 for more book information.
#---
require "rspec"
require_relative "rawk_2"
require_relative "spec_utils"

module Version2
  describe Rawk do
    before(:each) { create_marketing_documents }
    after(:each)  { delete_marketing_documents }

    it "lets you drop the r in the init block" do
      expect do
        rawk = Rawk.new do
          on_path("*.txt") { |path| puts path }

          on_file("*.txt") do |path|
            open(path) { |f| puts f.readline }
          end

          transform("*.txt") do |contents|
            contents.gsub!(/Spacely Sprockets/, "Coswell Cogs")
          end
        end

        rawk.run("marketing")
      end.to output(/ad_copy.*brochure/m).to_stdout
      expect(File.read("marketing/brochure.txt")).to match(/Coswell/)
    end
  end
end
