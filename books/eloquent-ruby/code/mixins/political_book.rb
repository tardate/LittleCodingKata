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

module Political
  class Document < ::Document; end

  class Document
    include WritingQuality
    # Rest of the class omitted...
  end

  class PoliticalBook < Document
    def number_of_cliches
      0
    end
    # Rest of the class omitted...
  end
end
