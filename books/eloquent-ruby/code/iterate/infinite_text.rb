#---
# Excerpted from "Eloquent Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/eruby2 for more book information.
#---
class InfiniteDoc
  include Enumerable

  def initialize(text)
    @words = text.split
  end

  def each(&block)
    return enum_for if not block

    while true
      block.call @words.sample
    end
  end
end
