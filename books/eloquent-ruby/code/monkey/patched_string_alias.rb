#---
# Excerpted from "Eloquent Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/eruby2 for more book information.
#---
require_relative "../common/document"

  class String
    alias_method :add, :+
  
    def +(other)
      if other.is_a?(Document)
        new_content = self + other.content
        return Document.new(
          title: other.title,
          author: other.author,
          content: new_content
        )
      end
      add(other)
    end
  end
