#---
# Excerpted from "Eloquent Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/eruby2 for more book information.
#---
# Demonstrate that a for is defined in terms of each.

class CollectionWrapper
  def initialize(contents)
    @contents = contents
  end

  def each(&block)
    puts "each called #{self}"
    @contents.each(&block)
  end
end

cw = CollectionWrapper.new([1,2,3])

# We should get the message from the each method.
cw.each { |x| puts "with each: #{x}" }

# ... and we should get the message again.
for x in cw
  puts "with for: #{x}"
end


