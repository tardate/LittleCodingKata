#---
# Excerpted from "Eloquent Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/eruby2 for more book information.
#---
# typed: true
require 'sorbet-runtime'

class Author
  extend T::Sig

  attr_reader :first_name, :last_name

  # sig { params(first_name: String, last_name: String }
  def initialize(first_name:, last_name:)
    @first_name = first_name
    @last_name = last_name
  end 
end
