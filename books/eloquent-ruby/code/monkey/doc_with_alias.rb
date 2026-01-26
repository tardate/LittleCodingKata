#---
# Excerpted from "Eloquent Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/eruby2 for more book information.
#---
require_relative "../common/document"

module AliasMethod
  class Document < ::Document; end
  
  class Document
    # Stuff omitted...

    # define the method.
    def word_count = words.size

    # Now give it two more names.
    alias_method :number_of_words, :word_count
    alias_method :size_in_words,   :word_count

    # Stuff omitted...
  end
end
