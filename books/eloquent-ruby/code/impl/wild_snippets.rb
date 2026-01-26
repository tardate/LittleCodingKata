#---
# Excerpted from "Eloquent Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/eruby2 for more book information.
#---
=begin
# See: TBD truffleruby/src/main/ruby/truffleruby/core/array.rb
class Array
  include Enumerable

  # Missive amount of code omitted...

  def each_index
    return to_enum(:each_index) { size } unless block_given?

    i = 0

    while i < size
      yield i
      i += 1
    end

    self
  end

  # ...
end
=end
