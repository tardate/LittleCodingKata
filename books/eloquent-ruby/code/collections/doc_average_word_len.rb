#---
# Excerpted from "Eloquent Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/eruby2 for more book information.
#---
require_relative "../common/document"

module AvgWordLenEach
  class Document < ::Document; end

  class Document
    # Most of the class omitted...

    # Compute the average word length. Note the use of fdiv to do 
    # floating point division.
    def average_word_length
      total = 0
      words.each { |word| total += word.size }
      total.fdiv(word_count)
    end
  end
end

module AvgWordLenReduce
  class Document < ::Document; end

  class Document 
    def average_word_length
      total = words.reduce(0) { |result, word| word.size + result }
      total.fdiv(word_count)
    end
  end
end

module AvgWordLenSumLong
  class Document < ::Document; end

  class Document 
    def average_word_length
      lengths = words.map {|w| w.size}
      total = lengths.sum
      total.fdiv(word_count)
    end
  end
end

module AvgWordLenSumShort
  class Document < ::Document; end

  class Document 
    def average_word_length
      total = words.map { |w| w.size }.sum
      total.fdiv(word_count)
    end
  end
end

module AvgWordLenSumIt
  class Document < ::Document; end

  class Document 
    def average_word_length
      total = words.map { it.size }.sum
      total.fdiv(word_count)
    end
  end
end

module AvgWordLenSumUnderbar
  class Document < ::Document; end

  class Document 
    def average_word_length
      total = words.map { _1.size }.sum
      total.fdiv(word_count)
    end
  end
end

module AvgWordLenUltimate
  class Document < ::Document; end

  class Document 
    def average_word_length
      words.map(&:size).sum.fdiv(word_count)
    end
  end
end
