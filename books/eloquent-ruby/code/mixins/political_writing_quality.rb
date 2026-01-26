#---
# Excerpted from "Eloquent Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/eruby2 for more book information.
#---
require_relative "../common/document"
require_relative "writing_quality"

module ModulePrecedence
  module PoliticalWritingQuality
    # No phrase is too worn out to be a cliché
    # in political writing.

    def number_of_cliches
      0
    end 
  end

  class PoliticalBook < Document
    include WritingQuality
    include PoliticalWritingQuality
    # Lots of stuff omitted...
  end
end
