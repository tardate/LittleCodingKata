#---
# Excerpted from "Eloquent Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/eruby2 for more book information.
#---
require "rspec"
require_relative "ebook_mult_mods"

module MultipleModules
  describe ElectronicBook do
    it "includes all of the modules" do
      expect(ElectronicBook.ancestors).to include(WritingQuality)
      expect(ElectronicBook.ancestors).to include(ProjectManagement)
      expect(ElectronicBook.ancestors).to include(AuthorAccountTracking)
    end
  end
end


