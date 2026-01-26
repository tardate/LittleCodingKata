#---
# Excerpted from "Eloquent Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/eruby2 for more book information.
#---
class Author
  attr_reader :first_name #: String
  attr_reader :last_name #: String

  # @rbs first_name: String
  # @rbs last_name: String
  # @rbs return: void
  def initialize(first_name:, last_name:)
    @first_name = first_name
    @last_name = last_name
  end 
end
