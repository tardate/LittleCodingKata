#---
# Excerpted from "Eloquent Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/eruby2 for more book information.
#---
require_relative "../common/document"


module ForIndex
  class Document < ::Document; end

  class Document
    def word_index(word, i = 0)
      words.each do |this_word|
        return i if word == this_word
        i += 1
      end
      nil 
    end
   end
end

module FindIndex
  class Document < ::Document; end

  class Document
    def word_index(word)
      words.find_index { |this_word| word == this_word }
    end
   end
end

