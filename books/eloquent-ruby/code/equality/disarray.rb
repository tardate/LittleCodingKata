#---
# Excerpted from "Eloquent Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/eruby2 for more book information.
#---
  class DisArray
    attr_reader :my_array
    def initialize(array=[])
      # Keep a copy of the array that is passed in.
      @my_array = array.clone
    end
  
    def ==(other)
      return false unless other.kind_of?(DisArray)
      @my_array == other.my_array
    end
    
    def eql?(other)
      return false unless other.kind_of?(DisArray)
      @my_array.eql?( other.my_array )
    end
    
    def hash
      @my_array.hash
    end
  
    # Rest of the class omitted...
  end
