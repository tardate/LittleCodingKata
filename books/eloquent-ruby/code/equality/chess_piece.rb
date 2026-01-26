#---
# Excerpted from "Eloquent Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/eruby2 for more book information.
#---
module Basic
  class ChessPiece
    include Comparable

    attr_reader :value

    Values = {pawn: 1, knight: 3, bishop: 3, rook: 5, queen: 9, king: 1_000_000}

  
    def initialize(piece)
      raise Exception("Invalid piece!") unless Values.has_key?(piece)
      @value = Values[piece]      # Hold onto the value of the piece.
    end
  
    # Return -1, 0, or 1...
    # Just fail if other doesn't have a .value method.
    def <=>(other)
      case
      when @value == other.value
        0
      when @value > other.value
        1
      else
        -1
      end
    end
  end
end

module Better
  class ChessPiece < Basic::ChessPiece; end

  class ChessPiece
    def <=>(other) = @value <=> other.value
  end
end
