#---
# Excerpted from "Eloquent Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/eruby2 for more book information.
#---
require "rspec"
require_relative "doc_with_quality"

module WithQualityModule
  describe Document do
    it "can spot cliches" do
      expect do
        text = "my way or the highway does the trick"
        my_tome = Document.new(title: 'Hackneyed', author: 'Russ', content: text)
        puts my_tome.number_of_cliches
      end.to output(/2/).to_stdout
    end

    it "knows it's ancestors" do
      pp Document.ancestors
    end
  end

  describe ElectronicBook do
    it "can spot cliches" do
      expect do
        text = "my way or the highway does the trick"
        my_tome = ElectronicBook.new(text)
        puts my_tome.number_of_cliches
      end.to output(/2/).to_stdout
    end
  end
end
