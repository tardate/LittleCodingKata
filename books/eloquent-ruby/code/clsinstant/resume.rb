#---
# Excerpted from "Eloquent Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/eruby2 for more book information.
#---
class Resume < Document
  @@default_font = :arial

  def self.default_font=(font)
    @@default_font = font
  end

  def self.default_font
    @@default_font
  end
  attr_accessor :font

  def initialize(title:, author:, content:)
    super(title:, author:, content:)
    @font = @@default_font
  end
  # Rest of the class omitted...
end
