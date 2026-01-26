#---
# Excerpted from "Eloquent Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/eruby2 for more book information.
#---
require_relative "../common/document"

module DocWithDescription
  class Document < ::Document; end

  class Document
    # Rest of the class taking a short break...

    # This method assumes that title is a Title and author is an Author.
    def description
      "Document: #{title.main_title} by #{author.last_name}"
    end
  end
end
