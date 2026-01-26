#---
# Excerpted from "Eloquent Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/eruby2 for more book information.
#---
require_relative "../common/document"

module EnumerableDoc
  class Document < ::Document; end

  class Document
    include Enumerable

    # Most of the class omitted...

    def each
      words.each { |word| yield word }
    end
  end

  class Document
    def each_word_pair
      words.each_cons(2) { |array| yield array[0], array[1] }
    end
  end
end
