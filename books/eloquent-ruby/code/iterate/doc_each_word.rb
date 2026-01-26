#---
# Excerpted from "Eloquent Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/eruby2 for more book information.
#---
require_relative "../common/document"

module DocWithEachWord
  class Document < ::Document; end

  class Document
    # Stuff omitted...
    def each_word
      word_array = words
      index = 0
      while index < words.size
        yield word_array[index]
        index += 1
      end
    end 
  end
end

module DocBetterEachWord
  class Document < ::Document; end

  class Document
    # Stuff omitted...
    def each_word
      words.each { |word| yield word }
    end 
  end
end
