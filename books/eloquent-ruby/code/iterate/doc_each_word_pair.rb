#---
# Excerpted from "Eloquent Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/eruby2 for more book information.
#---
require_relative "../common/document"

module DocEachWordPair
  class Document < ::Document; end

  class Document
    # Most of the class omitted...
    #
    def each_word_pair
      word_array = words
      index = 0
      while index < (word_array.size - 1)
        yield word_array[index], word_array[index+1]
        index += 1 
      end
    end
  end
end
