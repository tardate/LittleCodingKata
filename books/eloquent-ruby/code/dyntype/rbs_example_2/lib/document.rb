#---
# Excerpted from "Eloquent Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/eruby2 for more book information.
#---
require_relative "author"
require_relative "title"

class Document
  attr_accessor :title #: Title
  attr_accessor :author #: Author
  attr_accessor :content #: String

  # @rbs title: Title
  # @rbs author: Author
  # @rbs content: String
  # @rbs return: void
  def initialize(title:, author:, content:)
    @title = title
    @author = author
    @content = content
  end

  # @rbs return: Array[String]
  def words
    @content.split
  end

  # ...
 
  # @rbs return: Integer
  def word_count
    words.size
  end

  # This method assumes that title is a Title and author is an Author.
  def description
    "Document: #{title.main_title} by #{author.last_name}"
  end
end
