#---
# Excerpted from "Eloquent Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/eruby2 for more book information.
#---
require_relative "../common/document"

module WithPatMatch
  class Document < ::Document; end

  class Document
    # Most of the class omitted...

    def deconstruct_keys(_keys)
      {title: @title, author: @author, content: @content}
    end
  end

  class Document
    # Most of the class omitted...

    def deconstruct
      words
    end
  end
end
