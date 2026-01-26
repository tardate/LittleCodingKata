#---
# Excerpted from "Eloquent Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/eruby2 for more book information.
#---
class MyStruct
  def initialize(**values)
    @table = values.clone
  end

  def method_missing(mid, value=nil)
    if /.*=$/.match?(mid)
      name = mid[0..-2].to_sym
      @table[name] = value
      value
    else
      @table[mid]
    end
  end
end
