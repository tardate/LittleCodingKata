#---
# Excerpted from "Eloquent Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/eruby2 for more book information.
#---
require_relative "../common/document"

-3.abs             # Returns 3

# Call some methods on some objects

"abc".upcase       # "ABC"       
:abc.length        # 3
/abc/.class        # Regexp

# Call some methods on a couple of familiar objects

true.class         # Returns TrueClass
false.nil?         # False is not nil

true.class.class   # Returns Class

nil.class          # Returns NilClass
nil.nil?           # Yes, nil is indeed nil.
