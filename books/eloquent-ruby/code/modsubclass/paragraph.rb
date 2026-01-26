#---
# Excerpted from "Eloquent Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/eruby2 for more book information.
#---
class Paragraph
  attr_accessor :font, :font_size
  attr_accessor :text

  def initialize(font:, font_size:, text: "")
    @font = font
    @font_size = font_size
    @text = text
  end

  def to_s = @text

  # ...
end
