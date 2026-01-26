#---
# Excerpted from "Eloquent Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/eruby2 for more book information.
#---
  # Class that models a plain text document, complete with title
  # and author.
  #
  # @example
  #     doc = Document.new(
  #       title: "Hamlet",
  #       author: "Shakespeare",
  #       content: "To be or..."
  #     )
  #
  # @author Russ Olsen & Brandon Weaver
  class Document
  # ...
  
    # Creates a new instance of a Document
    #
    # @param title [String]
    #   Title of the Document
    # @param author [String]
    #   Author of the Document
    # @param content [String]
    #   The content of the Document
    #
    # @return [Document]
    def initialize(title:, author:, content:)
      @title = title
      @author = author
      @content = content
    end

  # Rest of the class omitted...
 
    # Using ngram analysis, compute the probability
    # that this document and the one passed in were
    # written by the same person. This algorithm is
    # known to be valid for American English and will
    # probably work for British and Canadian English.
    # @see https://en.wikipedia.org/wiki/N-gram N-Grams on Wikipedia
    #
    # @param other_document [Document]
    #   The document we are comparing to this one.
    #
    # @return Float
    def same_author_probability(other_document)
      # Implementation left as an exercise for the reader...
    end
 
  end

