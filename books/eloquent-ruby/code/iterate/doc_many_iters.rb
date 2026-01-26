#---
# Excerpted from "Eloquent Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/eruby2 for more book information.
#---
require_relative "../common/document"

module DocEachChar
  class Document < ::Document; end

  class Document
    def each_char
      # We are doing it the hard way here, but we could
      # also just use the each_char method on strings.
      index = 0
      while index < @content.size
        yield @content[index]
        index += 1
      end
    end
  end
end

module DocEachEachChar
  class Document < ::Document; end

  class Document
    # Stuff omitted

    def each
      # Iterate over the words, the easy way.
      words.each { |word| yield(word) }
     end
  
    def each_char
      # iterate over the characters, the easy way.
      @content.each_char { |ch| yield(ch) }
     end
  end
end

module DocEnumerators
  class Document < ::Document; end

  class Document
    # Stuff omitted

    def each
      if block_given?
        words.each { |word| yield(word) }
      else
        words.each
      end
     end
  
    def each_char
      if block_given?
        @content.each_char { |ch| yield(ch) }
      else
        @content.each_char
      end
     end
  end
end
