#---
# Excerpted from "Eloquent Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/eruby2 for more book information.
#---
require_relative "../common/document"

# Add authors with an array and no magic star.
#
module NoStar
  class Document < ::Document
    def initialize(author:, title:, content:)
      @author = ""
    end
  end

  class Document
    # Most of the class omitted...
  
    def add_authors(names)
      @author += " #{names.join(" ")}"
    end 
  end
end


# With the star example.

module WithStar
  class Document < ::Document
    def initialize(author:, title:, content:)
      super
      @author = ""
    end
  end

  class Document
    # Most of the class omitted...
    def add_authors(*names)
      @author += " #{names.join(" ")}"
    end
  end
end


