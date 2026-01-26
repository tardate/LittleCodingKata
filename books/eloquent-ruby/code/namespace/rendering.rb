#---
# Excerpted from "Eloquent Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/eruby2 for more book information.
#---
module Rendering
  class Font
    attr_accessor :name, :weight, :size

    def initialize(name:, weight: :normal, size: 10)
      @name = name
      @weight = weight
      @size = size
    end
    # Rest of the class omitted...
  end

  class PaperSize
    attr_accessor :name, :width, :height

    def initialize(name: "A4", width: 210, height: 297)
      @name = name
      @width = width
      @height = height
    end
    # Rest of the class omitted...
  end
end

module Rendering
  # Font and PaperSize classes omitted...

  DEFAULT_FONT = Font.new(name: "comic sans")
  DEFAULT_PAPER_SIZE = PaperSize.new
end

